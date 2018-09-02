<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintProve.aspx.cs" Inherits="Medical_treatment.PrintProve" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>證明</title>
    <style type="text/css">
        body{
            font-family:'標楷體';
            font-size:16pt
        }
    </style>
</head>
<body>
    <br/><br/><br/>
    <table style="width:100%;height:100%;text-align:center">
        <tr>
            <td style="width:5%"></td>
            <td style="width:15%;font-size:22pt">
                中<br/><br/>華<br/><br/>民<br/><br/>國<br/><br/><asp:Label runat="server" id="year"></asp:Label><br/><br/>年<br/><br/><asp:Label runat="server" id="Month"></asp:Label><br/><br/>月<br/><br/><asp:Label runat="server" id="Date"></asp:Label><br/><br/>日
            </td>
            <td style="width:30%">
                <table style="height:100%">
                    <tr>
                        <td style="height:50%"></td>
                    </tr>
                    <tr>
                        <td style="text-align:left;height:50%;font-size:14pt">證　整　館　建<br/>書　復　址　　<br/>字　師　：　安<br/>號　：　新　　<br/>：　謝　北　堂<br/>整　　　市　　<br/>復　　　板　國<br/>鑑　　　橋　　<br/>字　錦　區　術<br/>第　　　光　　<br/>一　　　明　館<br/>九　　　街<br/>五　標　八<br/>六　　　十<br/>號　　　四<br/>　　　　號<br/>　　　　一<br/>　　　　樓</td>
                    </tr>
                </table>
            </td>
            <td style="width:45%">
                <table style="width:100%;border: 3px solid" rules="all">
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="name"></asp:Label></td>
                        <td style="width:20%">姓<br/><br/>名</td>
                        <td rowspan="8" style="width:20%;font-size:22pt">民<br/>俗<br/>調<br/>理<br/>服<br/>務<br/>說<br/>明<br/>書</td>
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="Sex"></asp:Label></td>
                        <td>性<br/><br/>別</td>                        
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="Age"></asp:Label></td>
                        <td>年<br/><br/>齡</td>
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="Addr"></asp:Label></td>
                        <td>住<br/><br/>址</td>
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="Hurt"></asp:Label></td>
                        <td>損<br/>傷<br/>部<br/>位</td>                        
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="HDate"></asp:Label>&nbsp 起 <br /><asp:Label runat="server" id="HDate_1"></asp:Label>&nbsp 止</td>
                        <td>處<br/>置<br/>期<br/>間</td>
                    </tr>
                    <tr>
                        <td style="width:60%"><asp:Label runat="server" id="identity"></asp:Label></td>
                        <td>身<br/>分<br/>證<br/>號<br/>碼</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>備<br/><br/><br/>註</td>
                    </tr>
                </table>
            </td>
            <td style="width:5%"></td>
        </tr>
    </table>
</body>
</html>
