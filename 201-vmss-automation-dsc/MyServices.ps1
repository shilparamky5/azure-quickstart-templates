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
 
 

$acctKey = ConvertTo-SecureString -String "Ra9T3Gmz0wE4OHIVHTJJvi8X6C1nuC1oJIZrGWPMI+edW6EbLp3Hw6qmWQsodu00s0nv7SiB/wa1DvkLzS7xQA==" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\hedgebook", $acctKey
New-PSDrive -Name Z -PSProvider FileSystem -Root "\\hedgebook.file.core.windows.net\configuration" -Credential $credential -Persist
   

   File DirectoryCopy

    {

         DestinationPath = "C:\Users"

         Ensure = "Present"

         SourcePath = "Z:\"

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
