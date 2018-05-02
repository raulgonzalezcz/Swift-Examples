<?php
    //Create connection
    $connection = mysqli_connect("localhost","user","password","test");
    
    //RETRIEVE DATA
    $parameter = $_POST['parameter'];
    
    //Check if there are no errors in the connection
    if (mysqli_connect_errno()){
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }//end if
    
    //Statement in SQL
    $sqlStatement = "DELETE FROM mytable where myColumn='$parameter'";
    
    //Check if there are results
    if($connection -> query($sqlStatement) === TRUE){
        
        echo "Record deleted successfully";
    }//end if
    else{
        echo "Error to delete data". $sqlStatement;
    }
    //Close connection
    mysqli_close($connection);
?>
