Configuration MyServices
{
Import-DscResource –ModuleName 'PSDesiredStateConfiguration' 
Import-DscResource –ModuleName 'xPSDesiredStateConfiguration' 

Node "localhost"
  {
   	 WindowsFeature MessageQueueFeature
    {
     	Ensure = "Present"
      	Name = "MSMQ"
   	 }
    
    File TargetDir
    {
          Type='Directory'
          DestinationPath = "C:\DemoTo"
          Ensure = "Present"
    }
    
    xRemoteFile DownloadPackage        
    {             
       uri ="https://hedgebook.blob.core.windows.net/hedgebookv1/hbv1/hbv1.zip"             
       DestinationPath = "C:\DemoTo"  
       DependsOn = "[File]TargetDir"
       MatchSource = $false          
    }
 
   archive ZipFile 
   {
       Path = "C:\DemoTo\hbv1.zip"
       Destination = "C:\DemoTo"
       Ensure = 'Present'
   }
   
   archive ZipFile1 
   {
        Path = "C:\DemoTo\hbv1\isa_services.zip"
        Destination = "C:\"
        Ensure = 'Present'
    }
    
   archive ZipFile2
   {
        Path = "C:\DemoTo\hbv1\Resolution Software.zip"
        Destination = "C:\Program Files"
        Ensure = 'Present'
    }

   archive ZipFile4
   {
        Path = "C:\DemoTo\hbv1\RFSCommon.zip"
        Destination = "C:\Windows\System32"
        Ensure = 'Present'
    }

   archive ZipFile5
   {
        Path = "C:\DemoTo\hbv1\RFSCommonD.zip"
        Destination = "C:\Windows\System32"
        Ensure = 'Present'
   }

   
    Service PasService 
    {
          Name = "PAS Service"
          BuiltInAccount = "LocalSystem"
          Path = "C:\DemoTo\hbv1\isa_services\Pas.exe"
          StartupType = "Manual"
          State       = "Running"
     }

}

}

MyServices
