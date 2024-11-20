import streamlit as st
from fpdf import FPDF
import os
import google.generativeai as genai

genai.configure(api_key=["AIzaSyBFi8qYI_F0_DDt6gPsnfh2sFhquohel_w"])

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

def generate_gemini_report(intern_name, evaluations, mentor_name):
    chat_session = model.start_chat(history=[])

    input_text = f"""
    Create a detailed internship evaluation report for the intern named {intern_name} written by industry mentor {mentor_name}.
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
    
    Please generate a professional report based on the above information. Write this in a formal tone for an internship report that the industry mentor has to write for an intern.
    """

    response = chat_session.send_message(input_text)
    
    return response.text

def generate_pdf(intern_name, report_text):
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

    pdf.output(f"{intern_name}_Internship_Report.pdf")

def main():
    st.set_page_config(page_title="Internship Mentor Evaluation")
    st.title("Internship Mentor Evaluation")

    intern_name = st.text_input("Intern Name:")
    mentor_name = st.text_input("External Mentor Name:")

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
        'overall_performance': st.selectbox("Overall Performance:", ["Excellent", "Good", "Average", "Below Average", "Poor"])
    }

    if st.button("Generate Report"):
        if intern_name and mentor_name:  
          
            report_text = generate_gemini_report(intern_name, evaluations, mentor_name)  # Pass both intern_name and mentor_name
        
            generate_pdf(intern_name, report_text)
            st.success(f"Report for {intern_name} has been generated!")

            st.download_button(
                label="Download PDF Report",
                data=open(f"{intern_name}_Internship_Report.pdf", "rb").read(),
                file_name=f"{intern_name}_Internship_Report.pdf",
                mime="application/pdf"
            )
        else:
            st.error("Please enter both the intern's and mentor's names.")

if __name__ == "__main__":
    main()
