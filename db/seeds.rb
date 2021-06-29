# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  email_verified: true
)

employer = Employer.create(
  name: "Toys R Us",
  industry: "Retail"
)

career = Career.create(
  title: "Retail"
)

user_career = UserCareer.create(
  user: user,
  career: career
)

employment = Employment.create(
  title: "Cashier",
  start_date: "26 Nov 2008".to_date,
  end_date: "3 Jan 2009".to_date,
  starting_pay: 8.to_d,
  ending_pay: 8.to_d,
  user: user,
  employer: employer,
  user_career: user_career
)

location = Location.create(
  address: "123 Example Road",
  city: "Fort Collins",
  state: "CO",
  zipcode: "80528",
  country: "USA"
)

employer_location = EmployerLocation.create(
  employer: employer,
  location: location
)