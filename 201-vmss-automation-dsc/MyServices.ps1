Configuration MyServices

{

Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 





Node "localhost"

  {

   	 

     File TargetDir

    {

          Type='Directory'

          DestinationPath = "C:\DemoTo"

          Ensure = "Present"

    }

    

   



}



}



MyServices
