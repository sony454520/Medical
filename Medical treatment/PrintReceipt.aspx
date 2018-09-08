<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintReceipt.aspx.cs" Inherits="Medical_treatment.PrintReceipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/bootstrap-4.1.0.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-datepicker3.min.css" rel="stylesheet" />  
    <link href="Content/bootstrap3.3.7-glyphicon.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <link href="Content/sweetalert.css" rel="stylesheet" />
    <link href="Content/query.dataTables.min.css" rel="stylesheet" />    
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap-4.1.0.min.js"></script>
    <script src="Scripts/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/locales/bootstrap-datepicker.zh-TW.min.js"></script>
    <script src="Scripts/jquery-ui.min.js"></script>
    <script src="Scripts/sweetalert.js"></script>    
    <script src="Scripts/jquery.dataTables.min.js"></script>
    <title>證明</title>
    <style type="text/css">
        body{
            font-family:'SimSun';
            font-size:12pt
        }
        tr{
            height:25pt;
        }
        .showSweetAlert{
            font-family:'標楷體';
        }
    </style>
    <script type="text/javascript">        
        $(document).ready(function () {
            swal({ 
                title: "病例起始日期", 
                text: "請輸入病例起始日期：",
                type: "input", 
                showCancelButton: false, 
                closeOnConfirm: false, 
                animation: "slide-from-top", 
                inputPlaceholder: "起始日期" 
            },
            function(inputValue){ 
                if (inputValue === "" || inputValue === false ) { 
                    alert("請輸入病例起始日期！");
                    return false;
                }
                swal2();
                var date_str = inputValue;
                date_str = date_str.split("/");
                if (date_str.length == 3) {
                    $('#hdateYear').html(date_str[0]);
                    $('#hdateMonth').html(date_str[1]);
                    $('#hdateDay').html(date_str[2]);
                }
            });       
            var str = $('#hdateYear').html() + '/' + $('#hdateMonth').html() + '/' + $('#hdateDay').html();
            $('.showSweetAlert [type=text]').val(str);
            function swal2() {
                swal({
                    title: "病例結束日期",
                    text: "請輸入病例結束日期：",
                    type: "input",
                    showCancelButton: false,
                    closeOnConfirm: false,
                    animation: "slide-from-top",
                    inputPlaceholder: "結束日期"
                },
                function (inputValue) {
                    if (inputValue === "" || inputValue === false) {
                        alert("請輸入病例結束日期！");
                        return false;
                    }
                    var date_str = inputValue;
                    date_str = date_str.split("/");
                    if (date_str.length == 3) {
                        $('#hdateYear1').html(date_str[0]);
                        $('#hdateMonth1').html(date_str[1]);
                        $('#hdateDay1').html(date_str[2]);
                    }
                    swal("已修改日期！");
                });
                var str = $('#hdateYear1').html() + '/' + $('#hdateMonth1').html() + '/' + $('#hdateDay1').html();
                $('.showSweetAlert [type=text]').val(str);
            };
        });  
    </script>
</head>
<body>
    <br/><br/><br/>
        <table style="width:100%;border: 3px solid;text-align:center" rules="all">
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
