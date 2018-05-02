<?php
    //Create connection
    $connection = mysqli_connect("localhost","user","password","test");
    
    //Check if there are no errors in the connection
    if (mysqli_connect_errno()){
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }//end if
    
    //Statement in SQL
    $sqlStatement = "SELECT * FROM mytable";
    
    //Check if there are results
    if($resultSet = mysqli_query($connection, $sqlStatement)){
        
        //If so, then create a results array and a temporary one to hold the data
        $resultArray = array();
        $registerArray = array();
        
        //Loop through each row in the result set
        while($register = $resultSet -> fetch_object()){
            //Add each register into our results array
            $registerArray = $register;
            array_push($resultArray, $registerArray);
        }//end while
        
        //Finally, encode the array to JSON and send output
        echo json_encode($resultArray);
    }//end if
    
    //Close connection
    mysqli_close($connection);
?>
