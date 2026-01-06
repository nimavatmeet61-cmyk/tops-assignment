class ClinicAppointment:
    def __init__(self):
        self.appointments = {}
        self.time_slots = ["10am", "11am", "12pm", "2pm", "3pm"]
        self.max_per_slot = 3

    def get_mobile_input(self, prompt):
        """Helper function to safely get mobile number as int"""
        try:
            mobile = int(input(prompt).strip())
            return mobile
        except ValueError:
            print("Invalid mobile number! Please enter digits only.")
            return None

    def book_appointment(self):
        print("=== Book Appointment ===")
        name = input("Enter patient name: ").strip()
        age = input("Enter patient age: ").strip()
        mobile = self.get_mobile_input("Enter mobile number: ")
        if mobile is None:
            return
        doctor = input("Enter preferred doctor: ").strip()

        if doctor not in self.appointments:
            self.appointments[doctor] = {slot: [] for slot in self.time_slots}

        # Check if mobile already has an appointment
        for doc, slots in self.appointments.items():
            for patients in slots.values():
                for patient in patients:
                    if patient["mobile"] == mobile:
                        print("You already have an appointment!")
                        return

        # Show available slots
        print(f"Available time slots for Dr.{doctor}:")
        for slot in self.time_slots:
            print(f"{slot}: {len(self.appointments[doctor][slot])}/{self.max_per_slot} booked")

        chosen_slot = input("Enter desired time slot: ").strip()
        if chosen_slot not in self.time_slots:
            print("Invalid time slot!")
            return

        if len(self.appointments[doctor][chosen_slot]) >= self.max_per_slot:
            print("Sorry, this slot is full. Try another slot.")
            return

        # Book appointment
        self.appointments[doctor][chosen_slot].append({
            "name": name,
            "age": age,
            "mobile": mobile  # stored as int
        })
        print(f"Appointment confirmed with Dr.{doctor} at {chosen_slot}.")

    def view_appointment(self):
        print("=== View Appointment ===")
        mobile = self.get_mobile_input("Enter your mobile number: ")
        if mobile is None:
            return
        found = False
        for doctor, slots in self.appointments.items():
            for slot, patients in slots.items():
                for patient in patients:
                    if patient["mobile"] == mobile:
                        print(f"Appointment: Dr.{doctor} at {slot}, Patient: {patient['name']}, Age: {patient['age']}")
                        found = True
        if not found:
            print("No appointment found with this mobile number.")

    def cancel_appointment(self):
        print("=== Cancel Appointment ===")
        mobile = self.get_mobile_input("Enter your mobile number: ")
        if mobile is None:
            return
        found = False
        for doctor, slots in self.appointments.items():
            for slot, patients in slots.items():
                for patient in patients:
                    if patient["mobile"] == mobile:
                        patients.remove(patient)
                        print(f"Appointment cancelled for Dr.{doctor} at {slot}.")
                        found = True
                        return
        if not found:
            print("No appointment found with this mobile number.")


# --- Main Program ---
clinic = ClinicAppointment()

while True:
    print("\n=== Clinic Appointment System ===")
    print("1. Book Appointment")
    print("2. View Appointment")
    print("3. Cancel Appointment")
    print("4. Exit")
    choice = input("Enter your choice: ").strip()

    if choice == "1":
        clinic.book_appointment()
    elif choice == "2":
        clinic.view_appointment()
    elif choice == "3":
        clinic.cancel_appointment()
    elif choice == "4":
        print("Exiting...")
        break
    else:
        print("Invalid choice! Please try again.")