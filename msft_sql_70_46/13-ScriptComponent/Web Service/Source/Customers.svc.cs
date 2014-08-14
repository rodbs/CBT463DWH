using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace AW2012CustomerService
{   
    public class Customers : ICustomers
    {
        public Customer GetCustomer(int customerID)
        {
            AW2012DataContext aw = new AW2012DataContext();

            return aw.Customers.FirstOrDefault(c => c.BusinessEntityID == customerID);
        }

        public List<Customer> GetCustomers()
        {

            AW2012DataContext aw = new AW2012DataContext();

            return aw.Customers.ToList();
        }
        
        public List<Customer> GetCustomersByRegion(string region)
        {

            AW2012DataContext aw = new AW2012DataContext();

            return aw.Customers.Where(c => c.CountryRegionName == region).ToList();
        }
    }
}
