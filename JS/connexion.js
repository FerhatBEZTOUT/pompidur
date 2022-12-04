
$( document ).ready(function() {
    
    $("#connexionForm").submit(function (e) { 
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "../AJAX/login.php",
            data: $(this).serialize(),
            success: function (response) {
                console.log(response);
                if (response=='emp') {
                    window.location.href = '../dashboard.php';
                }
                else if (response=='adh') {
                    window.location.href = '../monespace.php';
                } else {
                    $("#error").removeClass("invisible");
                    $("#error").effect("shake");
                    
                }
            }
        });
    });
















});