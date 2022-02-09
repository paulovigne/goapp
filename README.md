ID       int64  `json:"id"`
Name     string `json:"name"`
Location string `json:"location"`
Age      int64  `json:"age"`

GET "/api/user/{id}"
GET "/api/user"
POST "/api/newuser"
PUT "/api/user/{id}"
DELETE "/api/deleteuser/{id}"

# Create Registry
curl -d '{"name":"paulo", "location":"rio", "age":38}'  -H "Content-Type: application/json" -X POST http://localhost:8080/api/newuser

# Update Registry
curl -d '{"name":"pedro", "location":"rio", "age":38}'  -H "Content-Type: application/json" -X PUT http://localhost:8080/api/user/{id}

# List Users
curl -H "Content-Type: application/json" -X GET http://localhost:8080/api/user

# User Details
curl -H "Content-Type: application/json" -X GET http://localhost:8080/api/user/{id}

# Delete User
curl -H "Content-Type: application/json" -X DELETE http://localhost:8080/api/deleteuser/{id}
