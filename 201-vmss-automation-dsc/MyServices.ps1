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
            Ensure = "Present"  
            Type = "Directory" 
            Recurse = $true
            SourcePath = "https://hedgebook.file.core.windows.net/?sv=2017-04-17&ss=bfqt&srt=sco&sp=rwdlacup&se=2017-12-21T19:49:52Z&st=2017-12-21T11:49:52Z&spr=https&sig=bazPRKZVAZYAnvJWEF1NWtbfzc9GcfMrENh7stBUyus%3D"
            DestinationPath = "C:\Users"
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
