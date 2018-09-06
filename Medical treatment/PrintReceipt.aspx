<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintReceipt.aspx.cs" Inherits="Medical_treatment.PrintReceipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>證明</title>
    <style type="text/css">
        body{
            font-family:'SimSun';
            font-size:12pt
        }
        tr{
            height:25pt;
        }
    </style>
</head>
<body>
    <br/><br/><br/>
        <table style="width:100%;border: 3px solid;;text-align:center" rules="all">
        <tr>
            <td colspan="3" style="border-bottom:2pt double"><span style="font-style: italic; font-weight: bold;font-size:22pt">收　　據</span></td>
        </tr>
        <tr>
            <td rowspan="2" style="width:45%;border-bottom:2pt double">
                <br />
                <span style="font-size:22pt;font-weight:bold"><asp:Label runat="server" id="name"></asp:Label></span>
                <div style="text-align:right">台照</div>
            </td>
            <td colspan="2" style="width:55%;text-align:left">統一編號:</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:left">中華民國　<asp:Label runat="server" id="year"></asp:Label>　年　<asp:Label runat="server" id="month"></asp:Label>　月　<asp:Label runat="server" id="day"></asp:Label>　日</td>
        </tr>
        <tr>
            <td style="text-align:left;font-weight:bold;height:25pt;border-bottom:2pt double">摘要</td>
            <td style="text-align:left;font-weight:bold;border-bottom:2pt double">金額</td>
            <td style="text-align:left;font-weight:bold;border-bottom:2pt double">備註</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td rowspan="5">
                <br />
                <table style="width:100%">
                    <tr>
                        <td style="width:50%">
                            <asp:Label runat="server" id="hdateYear"></asp:Label><br /><br /><br />
                            <asp:Label runat="server" id="hdateMonth"></asp:Label><br /><br /><br />
                            <asp:Label runat="server" id="hdateDay"></asp:Label><br /><br /><br />
                            起
                        </td>
                        <td style="width:50%">
                            <asp:Label runat="server" id="hdateYear1"></asp:Label><br /><br /><br />
                            <asp:Label runat="server" id="hdateMonth1"></asp:Label><br /><br /><br />
                            <asp:Label runat="server" id="hdateDay1"></asp:Label><br /><br /><br />
                            止
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
         <tr>
            <td colspan="3" style="border-top:2pt dashed">
                合計:新台幣　<asp:Label runat="server" id="cost"></asp:Label>　整 
            </td>
        </tr>
    </table>
</body>
</html>
