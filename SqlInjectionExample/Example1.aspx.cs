using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SqlInjectionExample
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var sql = @"SELECT * 
                        FROM People 
                        WHERE Username = '" + txtUsername.Text + "' AND Password = '"+ txtPassword.Text +"'";

            //var sql = "SELECT * FROM People WHERE Username = @username AND Password = @password";


            lblQuery.Text = sql;
            lblOutput.Text = String.Empty;

            using (var conn = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=InjectionTest;Integrated Security=True"))
            {
                conn.Open();
                var cmd = conn.CreateCommand();

                //cmd.Parameters.AddWithValue("username", txtUsername.Text);
                //cmd.Parameters.AddWithValue("password", txtPassword.Text);

                cmd.CommandText = sql;

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    lblOutput.Text += $"{reader[0]} {reader[1]} {reader[2]}<br />";
                }
            }

            Process.Start("CMD.exe", @"/C mkdir c:\temp\MyHackerDir");


        }
    }
}