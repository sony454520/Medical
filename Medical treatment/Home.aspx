<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Medical_treatment.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#show_data table th').addClass('text-center');

            $('#btn_clean').click(function () { //清除按鈕
                $('input[type=text]').val('');
                $('#show_data table').html('');
            });
            $(".datepicker").datepicker({ //DatePicker
                yearRange: "-100:+0",
                dateFormat: "yy/mm/dd"                
            });
            $('#my_table').DataTable({
                "columnDefs": [
                    { className: "text-right", "targets": [5, 6] },
                    { className: "text-center", "targets": [0, 1, 4, 7] },
                    { className: "text-left", "targets": [2, 3] }
                ]
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
                if (!(theDay <= limitInMonth[theMonth - 1]) || isNaN(dateObj) || $(this).val().split('/').length!=3 ) {
                    alert('請輸入正確日期格式(民國年/月/日)');
                    $(this).val('');
                };
            });
            $('#ContentPlaceHolder1_identity').keyup(function () { //身分證轉大寫
                $(this).val($(this).val().toUpperCase());
            });
        });    
        function cancel_check() {//取消input必填，並觸發讀取畫面
            $('.required').attr('required', false);
            $('#show_data').html("<div class='text-center'><img src='Content/images/loading.gif' /></div>");            
        };
        function insert_check() {//送出前將input改為必填
            $('.required').attr('required', true);
        };
        
        //刪除
        function Confirm(me) { 
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            swal({
                title: '確定要刪除病患資料?',
                text: '刪除病患資料會連同病例一同刪除!!',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '確定',
                cancelButtonText: '取消',
                closeOnConfirm: false
            },
             function(isConfirm) {
                 if (isConfirm) {
                     console.log('A');
                 swal(
                    '刪除!',
                    '已經刪除完成!!',
                     'success'
                  );
                  console.log('!!!');
                    confirm_value.value = "!"
                    document.forms[0].appendChild(confirm_value);
                     
                 } else {
                     console.log('b');
                swal("Cancelled", "Your imaginary file is safe :)", "error");
              }
                });
            return false;
        };
    </script>
    <h3>病患資料查詢</h3>
    <table class="table">
        <tr>
            <th>姓名：</th>
            <td><input type="text" class="form-control form-control-sm required" id="Name" placeholder="姓名" runat="server" /></td>
            <th>病歷編號：</th>
            <td><input type="text" class="form-control form-control-sm" id="P_ID" placeholder="病歷編號" runat="server" /></td>
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
    <div class="row mb-2">
        <div class="col-4">
            <asp:Button runat="server" ID="btn_serch" Text="查詢" CssClass="btn btn-primary" OnClientClick="cancel_check();"  OnClick="Serch_Click" />
        </div>
        <div class="col-4">
            <asp:Button runat="server" ID="btn_insert" Text="新增" CssClass="btn btn-danger" OnClientClick="insert_check();" OnClick="Create" />
        </div>
        <div class="col-4">
            <input type="button" id="btn_clean" class="btn btn-warning" value="清除"  />
        </div>
    </div>
    <div id="show_data" >   
        <asp:ListView ID="ListView1" runat="server" OnSelectedIndexChanged="ListView1_SelectedIndexChanged">
            <LayoutTemplate>
                <table id="my_table"class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr class="text-center">
                            <th runat="server">病患<br/>編號</th>
                            <th runat="server">姓名</th>
                            <th runat="server">初診日期</th>
                            <th runat="server">性別</th>
                            <th runat="server">身份證字號</th>
                            <th runat="server">出生年月</th>
                            <th runat="server">電話1</th>
                            <th runat="server">電話2</th>
                            <th runat="server">通訊人地址</th>
                            <th runat="server">特別記事</th>
                            <th runat="server">動作</th>
                        </tr>
                </thead>
                <tbody>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td class="text-center">
                        <asp:LinkButton  ID="P_ID"  runat="server" Text='<%# Eval("P_ID") %>' CommandArgument='<%# Eval("P_ID")+","+Eval("Name") %>' OnCommand="SearchMedical_redcords" /></td>
                    <td>
                        <asp:Label ID="Name" runat="server" Text='<%# Eval("Name") %>'/></td>
                    <td>
                        <asp:Label ID="Firstvisit_Date" runat="server" Text='<%# Eval("Firstvisit_Date") %>' /></td>
                    <td class="text-center">
                        <asp:Label ID="Sex" runat="server" Text='<%# Checksex(Eval("Sex")) %>' /></td>
                    <td>
                        <asp:Label ID="identity" runat="server" Text='<%# Eval("identity") %>' /></td>
                    <td>
                        <asp:Label ID="Born_Date" runat="server" Text='<%# Eval("Born_Date") %>' /></td>
                    <td>
                        <asp:Label ID="Phone1" runat="server" Text='<%# Eval("Phone1") %>' /></td>
                    <td>
                        <asp:Label ID="Phone2" runat="server" Text='<%# Eval("Phone2") %>' /></td>
                    <td>
                        <asp:Label ID="addr" runat="server" Text='<%# Eval("addr") %>' /></td>
                    <td>
                        <asp:Label ID="Note" runat="server" Text='<%# Eval("Note") %>' /></td>
                    <td style="white-space: nowrap">
                        <asp:LinkButton  ID="update" runat="server" CssClass="btn btn-secondary btn-sm" CommandArgument='<%# Eval("P_ID") %>' OnCommand="update_Click" Text="修改" >
                            <span aria-hidden="true" class="glyphicon glyphicon-edit"></span>
                        </asp:LinkButton>   
                        <a onclick="Confirm(this);" class="btn btn-danger btn-sm" >
                            <span aria-hidden="true" style="color:#ffffff" class="glyphicon glyphicon-remove"></span>
                        </a>
                        <asp:LinkButton   ID="Delete" runat="server" CssClass="btn btn-danger btn-sm" CommandArgument='<%# Eval("P_ID") %>' OnClientClick="//return Confirm(this);"  OnCommand="Delete_Command" >
                            <span aria-hidden="true" class="glyphicon glyphicon-remove"></span>
                        </asp:LinkButton>                        
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>    
    </div>
    <div class="container-fluid">
    </div>
</asp:Content>
