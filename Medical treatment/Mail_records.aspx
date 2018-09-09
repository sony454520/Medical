<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Mail_records.aspx.cs" Inherits="Medical_treatment.Mail_records" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            if ($('#ContentPlaceHolder1_M_TYPE').val() == "M_ID") {
                $('#ContentPlaceHolder1_bnt_new').hide();
                $('#btn_clear').hide();
            } else {
                 $('.btn_updated').attr('disabled', true);
            }
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
           
            $(document).on('click', '.m_id', function () {
                console.log('!!');
                $(".m_id").prop('checked', false);
                $(this).prop("checked", true)
                $(this).parent().nextAll().each(function () {
                    $('input.' + $(this).find('span').attr('class')).val($(this).find('span').html());
                });
                $('#ContentPlaceHolder1_M_ID').val($(this).val());
                if ($('#ContentPlaceHolder1_M_TYPE').val() == "P_ID") {
                    $('.btn_updated').attr('disabled', false);
                }
                //$('input.'+$(this).attr('class')).val($)
            });
            $("input[type='number']").keyup(function () {
                $(this).val($(this).val().replace("_i", '').replace('.', ''));
            });
            $('#btn_clear').click(function () {
                $('.btn_updated').attr('disabled', true);
                $('#edit_div input[type=text],input[type=number]').val('');
                $('.m_id:checked').prop('checked',false)
            });
            if ($('#ContentPlaceHolder1_M_ID').val() != "") {
                $('.m_id[value='+$('#ContentPlaceHolder1_M_ID').val() +']').click();
            }
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
    <h3>郵寄資料(<span class="foo"><asp:Label ID="FullName" runat="server"></asp:Label></span>)</h3>
    <div id="show_data">
        <asp:ListView ID="ListView1" runat="server">
            <LayoutTemplate>
                <table id="my_table" class="table table-striped table-bordered" style="width: 100%">
                    <thead>
                        <tr class="text-center">
                            <th runat="server">查<br />
                                看</th>
                            <th runat="server">郵寄<br />
                                日期</th>
                            <th runat="server">處方</th>
                            <th runat="server">處置<br />
                                金額</th>
                            <th runat="server">欠款<br />
                                金額</th>
                            <th runat="server">收件人</th>
                            <th runat="server">郵遞<br />
                                區號</th>
                            <th runat="server">地址</th>
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
                        <input type="checkbox" class="m_id" value='<%# Eval("M_ID") %>'>
                    </td>
                    <td class="text-center">
                        <asp:Label runat="server" CssClass="Send_Date" Text='<%# Eval("Send_Date") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="Medicine" Text='<%# Eval("Medicine") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="Cost" Text='<%# Eval("Cost") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="Owed" Text='<%# Eval("Owed") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="recipient" Text='<%# Eval("recipient") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="Zipcode" Text='<%# Eval("Zipcode") %>' /></td>
                    <td>
                        <asp:Label runat="server" CssClass="Addr" Text='<%# Eval("Addr") %>' /></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <hr />
    <div style="display: none">
        <input type="text" class="M_ID" runat="server" id="M_ID" readonly="readonly" />
        <input type="text" class="PP_ID" runat="server" id="PP_ID" readonly="readonly" />
        <input type="text" class="M_TYPE" runat="server" id="M_TYPE" readonly="readonly" />
    </div>
    <div id="edit_div">
        <div class="row mb-2">
            <div class="col-3">
                <label for="Send_Date">郵寄日期</label>
                <input type="text" class="form-control datepicker Send_Date" autocomplete="off" runat="server" id="Send_Date" required="required" />
            </div>
            <div class="col-3">
                <label for="recipient">收件人</label>
                <input type="text" class="form-control recipient" autocomplete="off" runat="server" id="recipient" required="required"  />
            </div>
        </div>
        <div class="mb-2">
            <label for="Medicine">處方</label>
            <input type="text" class="form-control medicine" runat="server" id="medicine" required="required" />
        </div>
        <div class="row mb-2">
            <div class="col-6">
                <label for="cost">處置費用</label>
                <input type="number" class="form-control cost" runat="server" id="cost" min="0" step="1" required="required" />
            </div>
            <div class="col-6">
                <label for="Owed">欠費金額</label>
                <input type="number" class="form-control Owed" runat="server" id="Owed" min="0"  />
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-2">
                <label for="Zipcode">郵遞區號</label>
                <input type="text" class="form-control Zipcode" runat="server" id="Zipcode"/>
            </div>
            <div class="col-10">
                <label for="Addr">地址</label>
                <input type="text" class="form-control Addr" runat="server" id="Addr" required="required"/>
            </div>
        </div>
        <div class="row mb-2 align-bottom">
            <div class="col-3">
                <asp:Button ID="bnt_new" runat="server" CssClass="btn btn-primary" Text="新增"  OnClick="btn_Insert_Click" />
           </div>
            <div class="col-3">
                 <asp:Button ID="btn_delete" runat="server" CssClass="btn btn-danger btn_updated" Text="刪除" OnClick="btn_Delete_Click"  />
            </div>
            <div class="col-3">
               <asp:Button ID="btn_edit" runat="server" CssClass="btn btn-primary btn_updated" Text="修改" OnClick="btn_Update_Click" />
            </div>
            <div class="col-3">
                <button id="btn_clear" type="button" class="btn btn-success">
                    <span class="glyphicon glyphicon-repeat"></span>清除</button>
            </div>
        </div>
    </div>
    <br />
</asp:Content>

