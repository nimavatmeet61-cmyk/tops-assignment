class BusReservation:
    def __init__(self):
        self.routes = {
            "Mumbai to Pune": 500,
            "Delhi to Jaipur": 600,
            "Bangalore to Mysore": 300,
            "Chennai to Coimbatore": 350
        }
        self.tickets = {}  # ticket_id: {name, age, mobile, route, seat}
        self.next_ticket_id = 1
        self.max_seats = 40

    def run(self):
        while True:
            print("\n=== Bus Reservation System ===")
            print("1. Show Available Routes")
            print("2. Book Ticket")
            print("3. View Ticket")
            print("4. Cancel Ticket")
            print("5. Exit")
            choice = input("Enter your choice: ").strip()

            if choice == "1":
                self.show_routes()
            elif choice == "2":
                self.book_ticket()
            elif choice == "3":
                self.view_ticket()
            elif choice == "4":
                self.cancel_ticket()
            elif choice == "5":
                print("Exiting system...")
                break
            else:
                print("Invalid choice! Enter 1-5.")

    def show_routes(self):
        print("\nAvailable Routes:")
        for route, price in self.routes.items():
            print(f"{route} - ₹{price}")

    def book_ticket(self):
        name = input("Passenger Name: ").strip()

        # Age
        try:
            age = float(input("Age in years: ").strip())
            if age < 0 or age > 120:
                print("Invalid age!")
                return
        except:
            print("Invalid age!")
            return

        # Mobile
        mobile = input("Mobile (10 digits): ").strip()
        if not (mobile.isdigit() and len(mobile) == 10):
            print("Invalid mobile number!")
            return

        # Show routes and get input
        print("\nAvailable Routes:")
        for route in self.routes:
            print(route)

        route_input = input("Enter route: ").strip()

        # Case-insensitive route check
        route_choice = None
        for route in self.routes:
            if route_input.lower() == route.lower():
                route_choice = route
                break

        if route_choice is None:
            print("Invalid route!")
            return

        # Seat assignment
        booked_seats = sum(1 for t in self.tickets.values() if t["route"] == route_choice)
        if booked_seats >= self.max_seats:
            print("Bus is full!")
            return

        seat_number = booked_seats + 1
        ticket_id = self.next_ticket_id
        self.next_ticket_id += 1

        # Save ticket
        self.tickets[ticket_id] = {
            "name": name,
            "age": age,
            "mobile": mobile,
            "route": route_choice,
            "seat": seat_number
        }

        print(f"Ticket booked! ID: {ticket_id}, Seat: {seat_number}, Price: ₹{self.routes[route_choice]}")

    def view_ticket(self):
        ticket_input = input("Enter Ticket ID: ").strip()
        if not ticket_input.isdigit():
            print("Invalid Ticket ID!")
            return
        ticket_id = int(ticket_input)

        if ticket_id in self.tickets:
            t = self.tickets[ticket_id]
            print(f"Ticket ID: {ticket_id}, Name: {t['name']}, Age: {t['age']}, "
                  f"Mobile: {t['mobile']}, Route: {t['route']}, Seat: {t['seat']}, Price: ₹{self.routes[t['route']]}")
        else:
            print("Ticket not found.")

    def cancel_ticket(self):
        ticket_input = input("Enter Ticket ID to cancel: ").strip()
        if not ticket_input.isdigit():
            print("Invalid Ticket ID!")
            return
        ticket_id = int(ticket_input)

        if ticket_id in self.tickets:
            del self.tickets[ticket_id]
            print(f"Ticket ID {ticket_id} cancelled.")
        else:
            print("Ticket not found.")


# Run the system
bus_system = BusReservation()
bus_system.run()