require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/employee")
require("./lib/division")
require("pg")

get('/') do
  @divisions = Division.all()
  erb(:index)
end

post("/employees") do
  employee_name = params.fetch("employee_name")
  division_id = params.fetch("division_id").to_i()
  employee = Employee.new({:employee_name => employee_name, :division_id => division_id})
  employee.save()
  @division = Division.find(division_id)
  erb(:division)
end

post("/divisions") do
  division_name = params.fetch("division_name")
  division = Division.new({:division_name => division_name, :id => nil})
  division.save()
  @divisions = Division.all()
  erb(:index)
end

get("/divisions/:id") do
  @division = Division.find(params.fetch("id").to_i())
  erb(:division)
end

get("/divisions/:id/edit") do
  @division = Division.find(params.fetch("id").to_i())
  erb(:division_edit)
end

patch("/divisions/:id") do
  division_name = params.fetch("division_name")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:division_name => division_name})
  erb(:division)
end

delete("/divisions/:id") do
  @division = Division.find(params.fetch("id").to_i())
  @division.delete()
  @divisions = Division.all()
  erb(:index)
end
