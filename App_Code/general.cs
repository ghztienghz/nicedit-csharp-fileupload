using System;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Collections.Generic;

public class general
{
    public class FileUpload
    {
        public string ID { get; set; }
        public Guid Guid { get; set; }
        public int ContentLength { get; set; }
        public string FileName { get; set; }
    }
    public static List<FileUpload> FileUploads
    {
        get
        {
            if (HttpContext.Current.Session["FileUploads"] == null)
                HttpContext.Current.Session["FileUploads"] = new  List<FileUpload>();
            return (List<FileUpload>)HttpContext.Current.Session["FileUploads"];
        }
    }
    
    public static string SystemURI
    {
        get
        {
            if (HttpContext.Current.Application["SystemURI"] == null)
            {
                string u = System.Web.Configuration.WebConfigurationManager.AppSettings["systemURI"].ToString();
                u += u.EndsWith("/") ? "" : "/";
                HttpContext.Current.Application["SystemURI"] = u;
            }
            return (string)HttpContext.Current.Application["SystemURI"];
        }
    }
}


