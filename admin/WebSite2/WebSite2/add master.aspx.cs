using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class add_master : System.Web.UI.Page
{
    SqlConnection cy;
    protected void Page_Load(object sender, EventArgs e)
    {
        cy = new SqlConnection("Data Source=WDS;Initial Catalog=hotel;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
    }

    protected void resert_add_Click(object sender, EventArgs e)
    {
        name_add.Text = null;
        address_add.Text = null;
        salary_add.Text = null;
        phone_add.Text = null;
    }

    protected void submit_add_Click(object sender, EventArgs e)
    {
        cy.Open();
        SqlCommand co = new SqlCommand("insert into student (student_ID,first_name,last_name) values('" + id_add.Text + "','" + first_name_add.Text + "','" + last_name_add.Text + "')", cy);
        co.ExecuteNonQuery();
        Response.Write("<script>alert('added successful!')</script>");
        name_add.Text = null;
        address_add.Text = null;
        salary_add.Text = null;
        phone_add.Text = null;
        cy.Close();
    }
}