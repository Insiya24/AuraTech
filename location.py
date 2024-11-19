from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
import geocoder
import smtplib

class LocationApp(App):
    def build(self):
        # Root layout
        layout = BoxLayout(orientation='vertical', padding=20, spacing=10)
        
        # Label to show messages
        self.label = Label(text="Click the button to send your location", size_hint=(1, 0.6))
        layout.add_widget(self.label)
        
        # Button to trigger location sharing
        button = Button(text="Send Location", size_hint=(0.5, 0.2), pos_hint={'center_x': 0.5})
        button.bind(on_press=self.send_location)
        layout.add_widget(button)
        
        return layout

    def send_location(self, instance):
        try:
            # Fetch current location using geocoder
            g = geocoder.ip('me')
            if g.ok:
                # Extract latitude and longitude
                location = f"Lat: {g.latlng[0]}, Lon: {g.latlng[1]}"
                self.label.text = f"Location: {location}"
                
                # Send location via email
                self.send_email(location)
            else:
                self.label.text = "Failed to fetch location."
        except Exception as e:
            self.label.text = f"Error: {str(e)}"

    def send_email(self, location):
        try:
            # Email credentials and configuration
            sender_email = "your_email@gmail.com"
            receiver_email = "coordinator_email@gmail.com"
            password = "your_email_password"
            
            # Email content
            subject = "Intern Location Update"
            body = f"The intern's current location is:\n{location}"
            email_message = f"Subject: {subject}\n\n{body}"
            
            # Sending the email
            with smtplib.SMTP("smtp.gmail.com", 587) as server:
                server.starttls()
                server.login(sender_email, password)
                server.sendmail(sender_email, receiver_email, email_message)
            
            self.label.text = "Location sent successfully!"
        except Exception as e:
            self.label.text = f"Failed to send email: {str(e)}"

if _name_ == "_main_":
    LocationApp().run()
