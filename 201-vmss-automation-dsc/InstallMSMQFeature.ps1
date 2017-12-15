Configuration InstallMSMQFeature
{
Import-DSCResource -ModuleName PSDesiredStateConfiguration, xNetworking

  Node "localhost"
  {
    WindowsFeature MessageQueueFeature
    {
      Ensure = "Present"
      Name = "MSMQ"
    }
  }
}
