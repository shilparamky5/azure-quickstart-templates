Configuration MyServices

{

Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 

Import-DscResource -ModuleName 'xPSDesiredStateConfiguration' 



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

    

    



   



}



}



MyServices
