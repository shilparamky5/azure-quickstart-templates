Configuration InstallMSMQFeature
{
  Node "localhost"
  {
    WindowsFeature MessageQueueFeature
    {
      Ensure = "Present"
      Name = "MSMQ"
    }
  }
}
