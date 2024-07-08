<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activation Email</title>
</head>
<body>
    <h2>Activate Your Account</h2>
    <p>
        Hello, <br>
        Copy your Unique ID and paste it along the text field on our application:<br>
        <?php echo e($uuid); ?>

    </p>
    <p>
        If you did not request this activation, please ignore this email.
    </p>
</body>
</html>
<?php /**PATH /Users/kevin/Documents/GitHub/playground/content-laravel-app/backend/resources/views/emails/activation.blade.php ENDPATH**/ ?>