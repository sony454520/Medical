<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Medical_records.aspx.cs" Inherits="Medical_treatment.Medical_records1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#div_Wound').hide();
            $("#div_Wound").css("width", $("#ContentPlaceHolder1_Wound").width() + "px");
            $(".datepicker").datepicker({ //DatePicker
                yearRange: "-100:+0",
                dateFormat: "yy/mm/dd"
            });
            $('.ui-datepicker-trigger').hide();
            $(".datepicker").click(function () {
                $(this).datepicker('show');
            });
            $('#btn_clear').click(function () {
                $('.btn_updated').attr('disabled', true);
                $('#edit_div input[type=text],input[type=number]').val('');
                $('.ph_id:checked').prop('checked',false)
            });
            $(".datepicker").change(function () { //判斷民國年格式
                var dateObj = new Date(Date.parse($(this).val()));
                var limitInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                var theYear = dateObj.getFullYear() + 1911;
                var theMonth = dateObj.getMonth();
                var theDay = dateObj.getDate();
                var isLeap = new Date(theYear, 1, 29).getDate() === 29;
                if (isLeap) {
                    limitInMonth[1] = 29;
                };
                if (!theDay <= limitInMonth[theMonth - 1] || isNaN(dateObj) || $(this).val().split('/').length != 3) {
                    alert('請輸入正確日期格式(民國年/月/日)');
                    $(this).val('');
                };
            });
            $('#my_table').DataTable({
                "columnDefs": [
                    { className: "text-right", "targets": [5, 6] },
                    { className: "text-center", "targets": [0, 1, 4, 7] },
                    { className: "text-left", "targets": [2, 3] }
                ]
            });
            $('.btn_updated').attr('disabled', true);
            $(document).on('click', '.ph_id', function () {
                $(".ph_id").prop('checked', false);
                $(this).prop("checked", true)
                $(this).parent().nextAll().each(function () {
                    $('input.' + $(this).find('span').attr('class')).val($(this).find('span').html());
                });
                $('.PH_ID').val($(this).val());
                $('.btn_updated').attr('disabled', false);
            });
            $("input[type='number']").keyup(function () {
                $(this).val($(this).val().replace("_i", '').replace('.', ''));
            });
            $('#btn_prove').click(function(){
                window.open("PrintProve.aspx?id="+$('#ContentPlaceHolder1_PH_ID').val(),'列印證明');
            });
            $('#btn_receipt').click(function(){
                window.open("PrintReceipt.aspx?id="+$('#ContentPlaceHolder1_PH_ID').val(),'列印收據');
            });
            //$("#ContentPlaceHolder1_Wound").focus(function () {
                //var position = $(this).position();
                //$("#div_Wound").css("top", position.top - $("#div_Wound").height() + "px");
                //$("#div_Wound").css("left", position.left + "px");
                //$('#div_Wound').show();
            //});
            //$("#ContentPlaceHolder1_Wound").focusout(function () {
                //$('#div_Wound').hide();
            //});
            
        });        
    </script>
    <h3>病歷資料(<span class="foo"><asp:Label ID="FullName" runat="server"></asp:Label></span>)</h3><br />
    <div id="show_data" >
        <asp:ListView ID="ListView1" runat="server">
         <LayoutTemplate>
            <table id="my_table"class="table table-striped table-bordered" style="width:100%">
              <thead>
                <tr class="text-center">
                    <th runat="server">查<br/>看</th>
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
                        <input type="checkbox" class="ph_id" value='<%# Eval("PH_ID") %>'>
                    </td>
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
    <div style="display:none">
        <input type="text" class="PH_ID" runat="server" id="PH_ID" readonly="readonly" />
    </div>
    <div id="edit_div">
        <div class="row mb-2">
            <div class="col-3">
                <label for="Date">病歷日期</label>
                <input type="text" class="form-control datepicker Hdate" autocomplete="off" runat="server" id="Hdate" required="required" />
            </div>
        </div>
        <div class="mb-2">
            <label for="Hurt">病因</label>
            <input type="text" class="form-control Wound" runat="server" id="Wound" />
        </div>
        <div class="mb-2">
            <label for="Medicine">處方</label>
            <input type="text" class="form-control medicine" runat="server" id="medicine" />
        </div>
        <div class="row mb-2">
            <div class="col-6">
                <label for="cost">處置費用</label>
                <input type="number" class="form-control cost" runat="server" id="cost" min="0" step="1" />
            </div>
            <div class="col-6">
                <label for="Owed">欠費金額</label>
                <input type="number" class="form-control Owed" runat="server" id="Owed" min="0"  />
            </div>
        </div>
        <div class="row mb-2 align-items-center">           
            <div class="col-6">
                <label for="Prove_Date">證明日期</label>
                <input type="text" runat="server" id="Prove_Date" class="form-control Prove_Date datepicker" autocomplete="off" />
            </div>
            <div class="col-6">
                <label for="Record_date">收據日期</label>
                <input type="text" id="Receipt_Date" runat="server" class="form-control Receipt_Date datepicker" autocomplete="off" />
            </div>  
        </div>
        <div class="row mb-2 align-bottom">
            <div class="col-2">
                <button id="btn_prove" type="button" class="btn btn-info btn_updated">
                  <span class="glyphicon glyphicon-print"></span> 列印證明
                </button>
            </div>
            <div class="col-2">
                <button id="btn_receipt" type="button" class="btn btn-info btn_updated">
                  <span class="glyphicon glyphicon-print"></span> 列印收據
                </button>
            </div>
            <div class="col-2">
                <asp:Button ID="btn_Delete" runat="server" CssClass="btn btn-danger btn_updated" Text="刪除" OnClientClick="btn_Delete_Click" OnClick="btn_Delete_Click"  />
            </div>
            <div class="col-2">
                <asp:Button ID="btn_Update" runat="server" CssClass="btn btn-primary btn_updated" Text="修改" OnClientClick="btn_Update_Click" OnClick="btn_Update_Click" />
            </div>
            <div class="col-2">
                <asp:Button ID="btn_Insert" runat="server" CssClass="btn btn-primary" Text="新增病歷" OnClientClick="Insert()" OnClick="btn_Insert_Click" />
            </div>
            <div class="col-2"> 
                <button id="btn_clear" type="button" class="btn btn-success">
                  <span class="glyphicon glyphicon-repeat"></span> 清除</button>
            </div>
        </div>
    </div>
    <br />
    <div id="div_Wound" class="row" style="position: absolute;background-color:#555555;height:500px">
         <div class="col-12" >
            <h3>123</h3>
        </div>
        <div class="col-6" style="background-color:#FFFFFF">
            A
        </div>
        <div class="col-6">
            123
        </div>
    </div> 
    <br />
</asp:Content>
