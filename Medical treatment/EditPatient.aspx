<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EditPatient.aspx.cs" Inherits="Medical_treatment.EditPatient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.required').attr('required', true);
            $(".datepicker").datepicker({ //DatePicker
                yearRange: "-100:+0",
                dateFormat: "yy/mm/dd"                
            });
            $('.ui-datepicker-trigger').hide();
            $(".datepicker").click(function () {
                $(this).datepicker('show');
            });
            $(".datepicker").change(function () { //判斷民國年格式
                 var dateObj = new Date(Date.parse($(this).val()));
                 var limitInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                 var theYear = dateObj.getFullYear()+1911;
                 var theMonth = dateObj.getMonth();
                 var theDay = dateObj.getDate();
                 var isLeap = new Date(theYear, 1, 29).getDate() === 29;
                  if(isLeap) {
                    limitInMonth[1] = 29;
                };
                if (!theDay <= limitInMonth[theMonth - 1] || isNaN(dateObj) || $(this).val().split('/').length!=3 ) {
                    alert('請輸入正確日期格式(民國年/月/日)');
                    $(this).val('');
                };
            });
            $('#ContentPlaceHolder1_identity').keyup(function () { //身分證轉大寫
                $(this).val($(this).val().toUpperCase());
            });
        });            
    </script>
     <h3>病患資料編輯</h3>
    <table id="my_table" class="table">
        <tr>
            <th>姓名：</th>
            <td><input type="text" class="form-control form-control-sm required" id="Name" placeholder="姓名" runat="server" /></td>
            <th>病歷編號：</th>
            <td><input type="text" class="form-control form-control-sm" readonly="readonly" id="P_ID" placeholder="病歷編號" runat="server" /></td>
            <th>身分證字號：</th>
            <td><input type="text" class="form-control form-control-sm required" id="identity" maxlength="10" placeholder="身分證字號" runat="server" /></td>
        </tr>
        <tr>
            <th>初診日期：</th>
            <td><input type="text" class="form-control form-control-sm datepicker" id="Firstvisit_Date" autocomplete="off"  placeholder="初診日期" runat="server"  /></td>
            <th>生日：</th>
            <td><input type="text" class="form-control form-control-sm datepicker required" id="Born_Date" autocomplete="off"  placeholder="生日" runat="server" /></td>
            <th>性別：</th>
            <td>
                 <asp:RadioButtonList ID="Sex" runat="server" RepeatDirection="Horizontal"  RepeatLayout="Flow">
                    <asp:ListItem Selected="True" Value="1">男</asp:ListItem>
                    <asp:ListItem Value="0">女</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <th>電話1：</th>
            <td><input type="text" class="form-control form-control-sm required" id="Phone1" placeholder="電話1" runat="server" /></td>
            <th>電話2：</th>
            <td><input type="text" class="form-control form-control-sm" id="Phone2" placeholder="電話2" runat="server" /></td>
            <th></th><td></td>
        </tr>
        <tr>
            <th>特別註記：</th>
            <td colspan="5"><input type="text" class="form-control form-control-sm" id="Note" placeholder="特別註記" runat="server" /></td>
        </tr>
        <tr>
            <th>住址：</th>
            <td colspan="5"><input type="text" class="form-control form-control-sm required" id="Addr" placeholder="住址" runat="server" /></td>
        </tr>
    </table>
     <div class="text-center">
        <asp:Button runat="server" ID="btn_serch" Text="更新" CssClass="btn btn-primary" OnClick="Update_Click" />　　
        <asp:Button runat="server" ID="btn_insert" Text="返回" CssClass="btn btn-danger" OnClick="Cancel_Click" />
    </div>
</asp:Content>