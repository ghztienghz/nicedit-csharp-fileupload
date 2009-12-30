<%@ Page Language="C#" %>
<%

    
    if (Request.QueryString["id"] != null)
    {
        HttpPostedFile pf = Request.Files[0];
        System.IO.FileInfo fi = new System.IO.FileInfo(pf.FileName);

        general.FileUpload fu = new general.FileUpload();
        fu.ContentLength = Request.ContentLength;
        fu.Guid = System.Guid.NewGuid();
        fu.ID = Request.QueryString["id"];
        fu.FileName = System.IO.Path.GetFileName(fi.FullName);
        general.FileUploads.Add(fu);
        
        pf.SaveAs(Server.MapPath(string.Concat(@"~\ContentImages\" , fu.Guid.ToString() , "_" , fu.ID, fi.Extension)));
        Response.Write("<div style='font-family:tahoma; font-size:11pt'>Dosyanız yükleniyor...</div>");
    }
    else if (Request.QueryString["check"] != null)
    {
        general.FileUpload fu = general.FileUploads.Find(delegate(general.FileUpload f)
        {
            if (f.ID == Request.QueryString["check"])
            { return true; }
            return false;
        });

        general.FileUploads.Remove(fu);
        string ext = new System.IO.FileInfo(fu.FileName).Extension;
        string url = string.Concat(general.SystemURI,"ContentImages/" + fu.Guid.ToString(), "_", fu.ID, ext);

        System.IO.StreamReader sr = new System.IO.StreamReader(Server.MapPath(string.Concat(@"~\ContentImages\", fu.Guid.ToString(), "_", fu.ID, ext)));
        System.Drawing.Image img = System.Drawing.Image.FromStream(sr.BaseStream);
        int w = img.Width;
        sr.Close();
        sr = null;
        Response.Write(string.Concat("nicUploadButton.statusCb({\"total\":", fu.ContentLength, ",\"current\":", fu.ContentLength, ",\"rate\":104777.386607,\"filename\":\"", fu.FileName, "\",\"name\":\"nicImage\",\"temp_filename\":\"\tmp\\phpLStDHi\",\"cancel_upload\":0,\"done\":1,\"start_time\":1261057064.27,\"url\":\"",url,"\",\"thumb\":\"", url, "\",\"width\":\"",w,"\",\"interval\":1000,\"count\":1});"));
    }
 %>