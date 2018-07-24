pragma solidity ^ 0.4.0;

contract HealthCareSystem
{
    
     uint idno;
    
    struct patient
    {
        uint Id;
        string Name;
        uint Age;
        string Disease;
        uint timeIn;
        uint timeOut;
        uint Noda;
        string Address;
        string Status;
        uint Billed_Amount;
        
    }
    
     mapping(uint=>patient) PatientDB;
    
    
    struct Disease{
        string disease_name;
        uint Treatment_Amount;
    }
    
   mapping(string=>Disease) DiseaseDB;
    
    string Admit = "Admit";
    string Discharge= "Discharge";
    uint Basic_Amount = 1000;
    
    
    function addDisease(string _disease,uint _TAmount)public returns(bool)
    {
        DiseaseDB[_disease].disease_name =_disease;
        DiseaseDB[_disease].Treatment_Amount = _TAmount;
        return true;
        
    }
    
    function addPatient(string _Name,uint _Age,string _Disease,string _Address)public returns(string,string,string)
    {
        uint id = getId();
        PatientDB[id].Id = id;
        PatientDB[id].Name = _Name;
        PatientDB[id].Age = _Age;
        PatientDB[id].Disease =_Disease;
        PatientDB[id].Address = _Address;
        PatientDB[id].Status = Admit;
        PatientDB[id].timeIn = now;
        
        return (PatientDB[id].Name,PatientDB[id].Address,PatientDB[id].Status);
        
    }
    
    
    function dischargePatient(uint _Id) public returns(bool)
    {
            PatientDB[_Id].Status = Discharge;
            PatientDB[_Id].timeOut = now;
            PatientDB[_Id].Noda = (((PatientDB[_Id].timeOut - PatientDB[_Id].timeIn)/60)/60)/24;
            PatientDB[_Id].Billed_Amount = Billing(_Id);
            return true;
            
      
        
    }
    
    
    function PatientDetails(uint _id)public  view returns(uint,string,uint,string,string,string,uint) 
    {
        return(PatientDB[_id].Id,PatientDB[_id].Name,PatientDB[_id].Age,PatientDB[_id].Disease,PatientDB[_id].Address,PatientDB[_id].Status,PatientDB[_id].Noda);
    }
    
    
    function getId()internal returns(uint)
    {
        return ++idno;
        
    }
    
    function Billing(uint _id) internal view returns(uint)
    {
        string storage Dname = PatientDB[_id].Disease;
        uint TAmount = DiseaseDB[Dname].Treatment_Amount;
        uint Fees = Basic_Amount+ TAmount + PatientDB[_id].Noda * 50;
        return(Fees);
    }
    
    function BillDetails(uint _Id)public view returns(uint,string,uint)
    {
        return(PatientDB[_Id].Id,PatientDB[_Id].Name,PatientDB[_Id].Billed_Amount);
    }
}
