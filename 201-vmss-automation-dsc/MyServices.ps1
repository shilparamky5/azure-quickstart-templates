Configuration MyServices

{

 Node "localhost"

  {





   	 WindowsFeature MessageQueueFeature

    	{

      	Ensure = "Present"

      	Name = "MSMQ"

    	}

     





        
         File DirectoryCopy
 {
 DestinationPath = "C:\Users"
 Credential = $storageCredential
 Ensure = "Present"
 SourcePath = "\\[hedgebook].file.core.windows.net\configuration"
 Type = "Directory"
 Recurse = $true
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
