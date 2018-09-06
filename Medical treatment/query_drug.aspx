<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="query_drug.aspx.cs" Inherits="Medical_treatment.query_drug" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script type="text/javascript">
        $(document).ready(function () {
            $('#show_data table th').addClass('text-center');
            $('.required').attr('required', true);
            $('#btn_clean').click(function () { //清除按鈕
                $('input[type=text]').val('');
                $('#show_data table').html('');
            });
            $(".datepicker").datepicker({ //DatePicker
                yearRange: "-100:+0",
                dateFormat: "yy/mm/dd"                
            });
            $('.ui-datepicker-trigger').hide();
            $(".datepicker").click(function () {
                $(this).datepicker('show');
            });
            $('#my_table').DataTable({
                "columnDefs": [
                    { className: "text-right", "targets": [5, 6] },
                    { className: "text-center", "targets": [0, 1, 4, 7] },
                    { className: "text-left", "targets": [2, 3] }
                ]
            });
            function loag_img() {
                  $('#show_data').html("<div class='text-center'><img src='Content/images/loading.gif' /></div>");
            };
            
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
                if (!(theDay <= limitInMonth[theMonth - 1]) || isNaN(dateObj) || $(this).val().split('/').length != 3) {
                    alert('請輸入正確日期格式(民國年/月/日)');
                    $(this).val('');
                };
            });
        });    

    </script>

    <h3>郵寄資料查詢</h3>
    <table class="table">
        <tr>
            <th>起始日期：</th>
            <td><input type="text" class="form-control form-control-sm datepicker required" id="sDate" autocomplete="off"  placeholder="起始日期" runat="server"  /></td>
            <th>截止日期：</th>
            <td><input type="text" class="form-control form-control-sm datepicker required" id="eDate" autocomplete="off"  placeholder="截止日期" runat="server" /></td>
         </tr>
        <tr>
            <th>收件人：</th>
            <td><input type="text" class="form-control form-control-sm" id="Name" placeholder="姓名" runat="server" /></td>
            <td colspan="2"><input id="hasmoney" type="checkbox" value="Y" runat="server" /><label for="hasmoney">只顯示欠款</label></td>
        </tr>
     </table>
    <div class="row mb-2">
        <div class="col-6 text-center">
            <asp:Button runat="server" ID="btn_serch" Text="查詢" OnClientClick="load_img()" CssClass="btn btn-primary"  OnClick="Serch_Click" />
        </div>
        <div class="col-6 text-center">
            <input type="button" id="btn_clean" class="btn btn-warning" value="清除"  />
        </div>
    </div>
</asp:Content>
