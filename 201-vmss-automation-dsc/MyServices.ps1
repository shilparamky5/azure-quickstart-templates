Configuration MyServices



{



Import-DscResource –ModuleName 'PSDesiredStateConfiguration' 



 Node "localhost"



  {





   	 WindowsFeature MessageQueueFeature



    	{



      	Ensure = "Present"



      	Name = "MSMQ"



    	}
 
 
 Credential AZURE\hedgebook{
    $password = "Ra9T3Gmz0wE4OHIVHTJJvi8X6C1nuC1oJIZrGWPMI+edW6EbLp3Hw6qmWQsodu00s0nv7SiB/wa1DvkLzS7xQA==" | ConvertTo-SecureString -asPlainText -Force
 }

    [PSCredential] $credential = Get-AzureRmAutomationCredential -ResourceGroupName "MarkToMarket" -AutomationAccountName "myAutomationAccount" -Name "AZURE\hedgebook" -Value $password


   
 
 
   

        

  File DirectoryCopy

         

    {

         DestinationPath = "C:\Users"

         Ensure = "Present"

         SourcePath = "\\hedgebook.file.core.windows.net\configuration"

         Type = "Directory"

         Recurse = $true

         Credential = $credential
   
   }
 



        Log AfterDirectoryCopy



        {



            # The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log



            Message = "Finished copying the PAS files with ID DirectoryCopy"



            DependsOn = "[File]DirectoryCopy" # This means run "DirectoryCopy" first.



        }



        



        archive ZipFile {



        Path = "C:\Users\isa_services.zip"



        Destination = "C:\Users"



        Ensure = 'Present'



 



        }







        Service PasService {







            Name = "PAS Service"



            BuiltInAccount = "LocalSystem"



            Path = "C:\Users\isa_services\Pas.exe"



            StartupType = "Manual"



            State       = "Running"







        }















}



}



MyServices
