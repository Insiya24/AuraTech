import streamlit as st
from fpdf import FPDF
import pandas as pd
import google.generativeai as genai

# Directly configure with your API key
genai.configure(api_key="AIzaSyBFi8qYI_F0_DDt6gPsnfh2sFhquohel_w")  # Replace YOUR_GEMINI_API_KEY with your actual key

# Configuration for the generative model
generation_config = {
    "temperature": 1,
    "top_p": 0.95,
    "top_k": 40,
    "max_output_tokens": 8192,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.0-pro",
    generation_config=generation_config,
)

def generate_gemini_report(intern_name, evaluations, assignment_marks, mentor_name, start_date, end_date):
    """Generate a detailed internship evaluation report using Gemini API."""
    chat_session = model.start_chat(history=[])

    input_text = f"""
    Create a detailed internship evaluation report for the intern named {intern_name}, 
    written by industry mentor {mentor_name}. The internship was conducted from {start_date} to {end_date}.
    
    Evaluation Factors:
    1. Professional Skills: {evaluations['professional_skills']}
    2. Soft Skills: {evaluations['soft_skills']}
    3. Problem-Solving Skills: {evaluations['problem_solving_skills']}
    4. Communication Skills: {evaluations['communication_skills']}
    5. Ability to Meet Deadlines: {evaluations['deadlines']}
    6. Ability to Work Independently: {evaluations['independence']}
    7. Collaboration Skills: {evaluations['collaboration_skills']}
    8. Technical Proficiency: {evaluations['technical_proficiency']}
    9. Creativity and Innovation: {evaluations['creativity']}
    10. Punctuality: {evaluations['punctuality']}
    11. Overall Performance: {evaluations['overall_performance']}
    
    Assignment Marks:
    {', '.join([f"Assignment {i+1}: {mark}/100" for i, mark in enumerate(assignment_marks)])}

    Please generate a structured formal internship report in a professional tone.
    Remove any astricks or hashtags. 
    """

    response = chat_session.send_message(input_text)
    
    if response and response.text:
        return response.text
    else:
        raise ValueError("Failed to generate a report from the Gemini API.")

def generate_pdf(intern_name, report_text):
    """Generate a PDF from the report text."""
    pdf = FPDF()
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.add_page()

    pdf.set_font("Arial", 'B', 16)
    pdf.cell(200, 10, txt="Internship Evaluation Report", ln=True, align='C')

    pdf.ln(10)
    pdf.set_font("Arial", size=12)
    pdf.cell(200, 10, txt=f"Intern Name: {intern_name}", ln=True)

    pdf.ln(10)
    pdf.set_font("Arial", size=12)
    pdf.multi_cell(0, 10, txt=report_text)

    file_path = f"{intern_name}_Internship_Report.pdf"
    pdf.output(file_path)
    return file_path

def main():
    st.set_page_config(page_title="Internship Mentor Evaluation", layout="wide")
    st.title("Internship Mentor Evaluation")

    with st.form("evaluation_form"):
        st.subheader("Internship Details")
        intern_name = st.text_input("Intern Name:")
        mentor_name = st.text_input("External Mentor Name:")
        start_date = st.date_input("Internship Start Date:")
        end_date = st.date_input("Internship End Date:")

        st.subheader("Evaluation Criteria")
        evaluations = {
            'professional_skills': st.selectbox("Professional Skills (Technical Knowledge, Task Completion):", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'soft_skills': st.selectbox("Soft Skills (Communication, Teamwork, Adaptability):", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'problem_solving_skills': st.selectbox("Problem-Solving Skills:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'communication_skills': st.selectbox("Communication Skills:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'deadlines': st.selectbox("Ability to Meet Deadlines:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'independence': st.selectbox("Ability to Work Independently:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'collaboration_skills': st.selectbox("Collaboration Skills:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'technical_proficiency': st.selectbox("Technical Proficiency:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'creativity': st.selectbox("Creativity and Innovation:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'punctuality': st.selectbox("Punctuality:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
            'overall_performance': st.selectbox("Overall Performance:", ["Excellent", "Good", "Average", "Below Average", "Poor"]),
        }

        st.subheader("Assignment Marks")
        num_assignments = st.number_input("Number of Assignments:", min_value=1, max_value=10, value=5)
        assignment_marks = []
        for i in range(num_assignments):
            marks = st.slider(f"Marks for Assignment {i+1}:", min_value=0, max_value=100, value=80)
            assignment_marks.append(marks)

        submit_button = st.form_submit_button("Generate Report")

    if submit_button:
        if intern_name and mentor_name and start_date and end_date:
            try:
                report_text = generate_gemini_report(intern_name, evaluations, assignment_marks, mentor_name, start_date, end_date)

                # Display the evaluations and assignment marks in a table
                st.subheader("Evaluation Summary")
                evaluation_df = pd.DataFrame.from_dict(evaluations, orient='index', columns=['Rating'])
                st.table(evaluation_df)

                st.subheader("Assignment Marks")
                marks_df = pd.DataFrame({
                    "Assignment": [f"Assignment {i+1}" for i in range(num_assignments)],
                    "Marks": assignment_marks
                })
                st.table(marks_df)

                # Generate and offer the PDF for download
                pdf_path = generate_pdf(intern_name, report_text)
                st.success(f"Report for {intern_name} has been successfully generated!")

                with open(pdf_path, "rb") as pdf_file:
                    st.download_button(
                        label="Download PDF Report",
                        data=pdf_file.read(),
                        file_name=f"{intern_name}_Internship_Report.pdf",
                        mime="application/pdf"
                    )
            except Exception as e:
                st.error(f"Error generating report: {str(e)}")
        else:
            st.error("Please fill in all required fields (Intern Name, Mentor Name, Start Date, End Date).")

if __name__ == "__main__":
    main()
