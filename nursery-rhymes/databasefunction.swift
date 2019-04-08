func submitAction(event) {

    //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
    //These are what a future team needs to update.
    let parameters = ["student": "5ca4f207b9cc5e1f7c944785",
        "program": "5ca4efc7b9cc5e1f7c944784",
        "focus_item":"",
        "correct_on": 1,
        "time_spent": 0]

    //create the url with URL
    //This is the post request for dealing with
    let url = URL(string: "https://teacherportal.hearatale.com/api/analytics/application")!

    //create the session object
    let session = URLSession.shared

    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
    } catch let error {
        print(error.localizedDescription)
    }

    //This is the authorization value for the test teacher of our application.
    request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjYTRlZDI1YjljYzVlMWY3Yzk0NDc4MyIsInR5cGUiOiJ0ZWFjaGVyIiwiaWF0IjoxNTU0MzEyNjU4fQ.LcPAhGDtkArvbfElXFjrhFl3vOyXX5fa3zUxPrvcn5U", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

        guard error == nil else {
            return
        }

        guard let data = data else {
            return
        }

        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                print(json)
                // handle json...
            }
        } catch let error {
            print(error.localizedDescription)
        }
    })
    task.resume()
}