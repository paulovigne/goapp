package router

import (
    "goapp/middleware"

    "github.com/gorilla/mux"
)

// Router is exported and used in main.go
func Router() *mux.Router {

    router := mux.NewRouter()

    router.Use(commonMiddleware)
    
    router.HandleFunc("/api/user/{id}", middleware.GetUser).Methods("GET", "OPTIONS")
    router.HandleFunc("/api/user", middleware.GetAllUser).Methods("GET", "OPTIONS")
    router.HandleFunc("/api/newuser", middleware.CreateUser).Methods("POST", "OPTIONS")
    router.HandleFunc("/api/user/{id}", middleware.UpdateUser).Methods("PUT", "OPTIONS")
    router.HandleFunc("/api/deleteuser/{id}", middleware.DeleteUser).Methods("DELETE", "OPTIONS")

    return router
}

func commonMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        w.Header().Add("Content-Type", "application/json")
        next.ServeHTTP(w, r)
    })
}
