


<?php
     
        $user='root';
        $password='';
        $hostname='127.0.0.1';
        
           $db  = new PDO( 'mysql:host=127.0.0.1;port=3306;dbname=oblig5;charset=utf8mb4',$user,$password) ;// Create PDO connection
           //$db ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);


$doc = new DOMDocument();
$doc->load('SkierLogs.xml');
$total_distance ='0';



$Clubs= $doc->getElementsByTagName("Clubs");
	
			$Club= $doc->getElementsByTagName("Club");

			foreach($Club as $Club)
			{
			
		   	     $ID= $Club->getAttribute("id");
     
     			     $Names  = $Club->getElementsByTagName( "Name" );
     			     $Name   = $Names->item(0)->nodeValue;
     
     			     $Cities = $Club->getElementsByTagName( "City" );
     			     $City   = $Cities->item(0)->nodeValue;
     
     			     $Counties = $Club->getElementsByTagName( "County" );
     			     $County   = $Counties->item(0)->nodeValue;
     
   
     			           $sql = "INSERT INTO location(city, county) VALUES(:City, :County)";
                           $query = $db->prepare($sql);
                           $query->execute(array(":City"=>$City,":County"=>$County));
     			     	   $sql = "INSERT INTO club(ID, city, xname) VALUES(:ID, :City, :xname)";
                           $query = $db->prepare($sql);
                           $query->execute(array(":ID"=>$ID,":City"=>$City,":xname"=>$Name));
            }

$Skiers = $doc->getElementsByTagName("Skiers");
				$Skier = $Skiers[0]->getElementsByTagName('Skier');
				foreach($Skier as $Skier)
				{
				        $username = $Skier->getAttribute("userName");
				        $firstnames= $Skier->getElementsByTagName("FirstName");
				        $firstname = $firstnames->item(0)->nodeValue;
       				    $lastnames = $Skier->getElementsByTagName("LastName");
       				    $lastname  = $lastnames->item(0)->nodeValue;
       		            $yearofbirths= $Skier->getElementsByTagName("YearOfBirth");
				        $yearofbirth= $yearofbirths->item(0)->nodeValue;
					    $sql = "INSERT INTO skier(username, firstname, lastname, yearofbirth) VALUES(:username,:firstname,:lastname,:yearofbirth)";
                        $query = $db->prepare($sql);
                        $query->execute(array(":username"=>$username,":firstname"=>$firstname,":lastname"=>$lastname,":yearofbirth"=>$yearofbirth));
				}



$Seasons=$doc->getElementsByTagName("Season");
$sql = "INSERT INTO club(ID) VALUES(:ID)";
                		    $query = $db->prepare($sql);                  
                 			$query->execute(array(":ID"=>" "));

	foreach( $Seasons as $Season)
	{  
		$fallyear =$Season->getAttribute("fallYear");
			 $sql = "INSERT INTO season(fallyear) VALUES(:fallyear)";
             $query = $db->prepare($sql);   
             $query->execute(array(":fallyear"=>$fallyear)); 

        $Skiers=$Season->getElementsByTagName("Skiers");
			foreach( $Skiers as $Skiers)
			{ 
				$clubId =$Skiers->getAttribute("clubId");
				if($clubId=='...')
					$clubId=" ";

				$clubskiiers=$Skiers->getElementsByTagName("Skier");
				foreach($clubskiiers as $Skier)
					{
							$total_distance=0;

						   $skierusername=$Skier->getAttribute("userName");
							$sql = "INSERT INTO seasonskiers(seasonyear,clubid,skierusername) VALUES(:seasonyear, :clubId, :skierusername)";
                		    $query = $db->prepare($sql);                  
                 			$query->execute(array(":seasonyear"=>$fallyear, ":clubId"=>$clubId, ":skierusername"=>$skierusername)); 

						$Logs=$Skier->getElementsByTagName("Log");
					
						foreach( $Logs as $Log)
						{
							
							$Entries=$Log->getElementsByTagName("Entry");
							           foreach( $Entries as $Entry)
							           {
							           
										
							           	$Dates= $Entry->getElementsByTagName("Date");
							           	$Date= $Dates->item(0)->nodeValue;
				 			           	$Areas= $Entry->getElementsByTagName("Area");
				 			           	$Area= $Areas->item(0)->nodeValue;
				 			           	$Distances= $Entry->getElementsByTagName("Distance");
				 			           	$Distance= $Distances->item(0)->nodeValue;
				 			           	$total_distance+=$Distance;

				 			           		$sql = "INSERT INTO logentry(seasonyear,skierusername, logdate,distance, area) VALUES(:seasonyear, :skierusername, :logdate, :distance, :area)";
                		               		$query = $db->prepare($sql);                  
                 			           		$query->execute(array(":seasonyear"=>$fallyear, ":skierusername"=>$skierusername, ":logdate"=>$Date, ":distance"=>$Distance, ":area"=>$Area));
							        
         
							           }

							       

							           	$sql = "INSERT INTO log(seasonyear,skierusername,totaldistance) VALUES(:seasonyear, :skierusername,:totaldistance)";
                		    			$query = $db->prepare($sql);                  
                 						$query->execute(array(":seasonyear"=>$fallyear, ":skierusername"=>$skierusername, ":totaldistance"=>$total_distance));




							           /*$sql = "UPDATE `log` set `totaldistance`='$total_distance' where `skierusername`='$skierusername' AND `seasonyear`='$fallyear'";
                		    		$query = $db->prepare($sql);                  
                 					$query->execute();*/ 
							
						}
						
							


					}
            }
	}

?>













