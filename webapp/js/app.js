$(function () {

    Parse.initialize("aoWP4aBIRnvGYjJE10G3mfRW9mIyEkk1tZZeMQtf", "da0FRNevITi0KCteLAA8KkbC8kraFrg49LnlngfA");

    /*var TestObject = Parse.Object.extend("TestObject");
    var testObject = new TestObject();
    testObject.save({
        foo: "bar"
    }, {
        success: function (object) {
            $(".success").show();
        },
        error: function (model, error) {
            $(".error").show();
        }
    });*/

    var user = new Parse.User();
    user.set("username", "teacher");
    user.set("password", "admin");
    user.set("email", "icw@cmu.edu");

    // other fields can be set just like with Parse.Object
    //user.set("phone", "650-555-0000");

    user.signUp(null, {
        success: function (user) {
        	console.log("Signed up successfully!")
            // Hooray! Let them use the app now.
        },
        error: function (user, error) {
            // Show the error message somewhere and let the user try again.
            alert("Error: " + error.code + " " + error.message);
        }
    });

});