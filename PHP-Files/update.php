<?php
    //Create connection
    $connection = mysqli_connect("localhost","user","password","test");
    
    //RETRIEVE DATA
    $oldValue = $_POST['parameter1'];
    $newValue = $_POST['parameter2'];
    
    //Check if there are no errors in the connection
    if (mysqli_connect_errno()){
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }//end if
    
    //Statement in SQL
    $sqlStatement = "UPDATE mytable SET myColumn='$newValue' WHERE myColumn='$oldValue'";
    
    //Check if there are results
    if($connection -> query($sqlStatement) === TRUE){
        echo "Record updated successfully";
    }//end if
    else{
        echo "Error to update data". $sqlStatement;
    }
    //Close connection
    mysqli_close($connection);
?>
