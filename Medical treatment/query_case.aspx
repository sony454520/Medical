<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="query_case.aspx.cs" Inherits="Medical_treatment.query_case" %>

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
        $(document).on('click', '.print_prove', function () {
            window.open("PrintProve.aspx?id="+$(this).data('id'),'列印證明');
        })
    </script>
    <h3>病歷資料查詢</h3>
    <table class="table">
        <tr>
            <th>起始日期：</th>
            <td><input type="text" class="form-control form-control-sm datepicker required" id="sDate" autocomplete="off"  placeholder="起始日期" runat="server"  /></td>
            <th>截止日期：</th>
            <td><input type="text" class="form-control form-control-sm datepicker required" id="eDate" autocomplete="off"  placeholder="截止日期" runat="server" /></td>
         </tr>
        <tr>
            <th>姓名：</th>
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
   <div id="show_data" >
        <asp:ListView ID="ListView1" runat="server">
         <LayoutTemplate>
            <table id="my_table"class="table table-striped table-bordered" style="width:100%">
              <thead>
                <tr class="text-center">
                    <th runat="server">列<br/>印<br />證<br />明</th>
                    <th runat="server">姓名</th>
                    <th runat="server">就診<br/>日期</th>
                    <th runat="server">病因</th>
                    <th runat="server">處方</th>
                    <th runat="server">證明<br/>日期</th>
                    <th runat="server">處置<br/>費用</th>
                    <th runat="server">欠費<br/>金額</th>
                    <th runat="server">收據<br/>日期</th>
                </tr>
            </thead>
            <tbody>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
             </tbody>
         </table>
        </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <div data-id="<%# Eval("PH_ID")%>" class="btn btn-info btn_updated print_prove">
                          <span class="glyphicon glyphicon-print"></span>
                        </div>
                    </td>
                    <td><asp:Label runat="server" CssClass="Wound" Text='<%# Eval("Name") %>'/></td>
                    <td class="text-center"><asp:Label runat="server" CssClass="Hdate" Text='<%# Eval("HDate") %>'/></td>
                    <td><asp:Label runat="server" CssClass="Wound" Text='<%# Eval("Wound") %>'/></td>
                    <td><asp:Label runat="server" CssClass="medicine" Text='<%# Eval("medicine") %>' /></td>
                    <td><asp:Label runat="server" CssClass="Prove_Date" Text='<%# Eval("Prove_Date") %>' /></td>
                    <td><asp:Label runat="server" CssClass="cost" Text='<%# Eval("cost") %>' /></td>
                    <td><asp:Label runat="server" CssClass="Owed" Text='<%# Eval("Owed") %>' /></td>
                    <td><asp:Label runat="server" CssClass="Receipt_Date" Text='<%# Eval("Receipt_Date") %>' /></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>    
    </div>
    <hr />
</asp:Content>