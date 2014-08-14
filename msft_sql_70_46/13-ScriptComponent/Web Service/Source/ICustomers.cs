using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace AW2012CustomerService
{    
    [ServiceContract]
    public interface ICustomers
    {

        [OperationContract]
        Customer GetCustomer(int customerID);

        [OperationContract]
        List<Customer> GetCustomers();

        [OperationContract]
        List<Customer> GetCustomersByRegion(string region);

    }
}
