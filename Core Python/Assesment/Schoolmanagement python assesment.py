class SchoolManagement:
    def __init__(self):
        self.students = {}  # Store student records
        self.next_id = 1    # Auto-increment student ID

    def run(self):
        while True:
            print("\n=== School Management System ===")
            print("1. New Admission")
            print("2. View Student Details")
            print("3. Update Student Info")
            print("4. Remove Student Record")
            print("5. Exit")
            choice = input("Enter your choice: ").strip()

            if choice == "1":
                self.new_admission()
            elif choice == "2":
                self.view_student()
            elif choice == "3":
                self.update_student()
            elif choice == "4":
                self.remove_student()
            elif choice == "5":
                print("Exiting system...")
                break
            else:
                print("Invalid choice! Enter 1-5.")

    def new_admission(self):
        print("\n--- New Admission ---")
        name = input("Student Name: ").strip()

        # Age input with combined numeric and range check
        try:
            age = int(input("Age (5-18): ").strip())
            if age < 5 or age > 18:
                raise ValueError("Age must be between 5 and 18.")
        except ValueError as e:
            print("Invalid age!", e)
            return

        # Class input with combined numeric and range check
        try:
            student_class = int(input("Class (1-12): ").strip())
            if student_class < 1 or student_class > 12:
                raise ValueError("Class must be between 1 and 12.")
        except ValueError as e:
            print("Invalid class!", e)
            return

        # Mobile number check
        mobile = input("Guardian Mobile (10 digits): ").strip()
        if not (mobile.isdigit() and len(mobile) == 10):
            print("Invalid mobile number!")
            return

        # Assign student ID and save
        student_id = self.next_id
        self.next_id += 1
        self.students[student_id] = {
            "name": name,
            "age": age,
            "class": student_class,
            "mobile": mobile
        }

        print(f"Admission successful! Student ID: {student_id}")

    def view_student(self):
        print("\n--- View Student Details ---")
        student_id_input = input("Enter Student ID: ").strip()
        if not student_id_input.isdigit():
            print("Invalid ID!")
            return
        student_id = int(student_id_input)

        if student_id in self.students:
            student = self.students[student_id]
            print(f"ID: {student_id}, Name: {student['name']}, Age: {student['age']}, "
                  f"Class: {student['class']}, Mobile: {student['mobile']}")
        else:
            print("No student found with this ID.")

    def update_student(self):
        print("\n--- Update Student Info ---")
        student_id_input = input("Enter Student ID: ").strip()
        if not student_id_input.isdigit():
            print("Invalid ID!")
            return
        student_id = int(student_id_input)

        if student_id not in self.students:
            print("No student found with this ID.")
            return

        print("1. Update Mobile")
        print("2. Update Class")
        choice = input("Enter choice: ").strip()
        if choice == "1":
            mobile = input("Enter new 10-digit mobile number: ").strip()
            if not (mobile.isdigit() and len(mobile) == 10):
                print("Invalid mobile number!")
                return
            self.students[student_id]['mobile'] = mobile
            print("Mobile updated successfully.")
        elif choice == "2":
            try:
                new_class = int(input("Enter new class (1-12): ").strip())
                if new_class < 1 or new_class > 12:
                    raise ValueError("Class must be between 1 and 12.")
            except ValueError as e:
                print("Invalid class!", e)
                return
            self.students[student_id]['class'] = new_class
            print("Class updated successfully.")
        else:
            print("Invalid choice!")

    def remove_student(self):
        print("\n--- Remove Student Record ---")
        student_id_input = input("Enter Student ID: ").strip()
        if not student_id_input.isdigit():
            print("Invalid ID!")
            return
        student_id = int(student_id_input)

        if student_id in self.students:
            del self.students[student_id]
            print(f"Student ID {student_id} removed successfully.")
        else:
            print("No student found with this ID.")


# --- Run the system ---
school = SchoolManagement()
school.run()