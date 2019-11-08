# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimesheetSpa.Repo.insert!(%TimesheetSpa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query
alias TimesheetSpa.Repo
alias TimesheetSpa.Users.User
alias TimesheetSpa.Roles.Role
alias TimesheetSpa.Sheets.Sheet
alias TimesheetSpa.Jobs.Job
alias TimesheetSpa.Tasks.Task

IO.puts "[INFO] Deleting Users and Roles"
Repo.delete_all(User)
Repo.delete_all(Role)
IO.puts "[INFO] Deleted.."


IO.puts "Inserting roles"
Repo.insert!(%Role{role_id: 1, desc: "employee"})
Repo.insert!(%Role{role_id: 2, desc: "manager"})
IO.puts "Inserted"

employee = Repo.get_by(Role, role_id: 1)
manager = Repo.get_by(Role, role_id: 2)

IO.puts "Inserting users"
Repo.insert!(%User{name: "Naezy", email: "naezy@gullygang.com", role: employee.id} )
Repo.insert!(%User{name: "Divine", email: "divine@gullygang.com", role: manager.id} )
IO.puts "Inserted"

IO.puts "inserting jobs"
job = Repo.insert!(%Job{job_code: "AX589", manager_id: manager.id} )
job = Repo.insert!(%Job{job_code: "AX590", manager_id: manager.id} )
IO.puts "Inserted"

Repo.insert!( %Sheet{ total_hours: 4, user_id: employee.id } )

IO.puts "Inserting a dummy sheet"
sheet = Repo.get_by( Sheet, user_id: employee.id )
IO.puts "Inserted"

IO.puts "Inserting a task associated with the dummy sheet"
Repo.insert!( %Task{ hours: 4, sheet: sheet.id, user_id: employee.id, job_code: job.id} )
IO.puts "Inserted"
