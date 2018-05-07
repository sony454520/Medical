<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Medical_treatment.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("是否確定刪除資料?")) {
                confirm_value.value = "是";
            } else {
                confirm_value.value = "否";
            }
            document.forms[0].appendChild(confirm_value);
        };


    </script>
    <div class="container">
        <%--<form class="needs-validation" novalidate>
        </form>--%>
        <div class="row">
            <div class="col-4 mb-3">
                <label for="Name">姓名：</label>
                <input type="text" class="form-control" id="Name" placeholder="姓名" runat="server" />
            </div>
            <div class="col-4 mb-3">
                <label for="P_ID">病歷編號：</label>
                <input type="text" class="form-control" id="P_ID" placeholder="病歷編號" runat="server" />
            </div>
            <div class="col-4 mb-3">
                <label for="identity">身分證字號：</label>
                <input type="text" class="form-control" id="identity" placeholder="身分證字號：" runat="server" />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-4">
                <label for="Firstvisit_Date">初診日期：</label>
                <input type="text" class="form-control" id="Firstvisit_Date" runat="server" />
            </div>
            <div class="col-4">
                <label for="Born_Date">生日：</label>
                <input type="text" class="form-control" id="Born_Date" runat="server" />
            </div>
            <div class="col-4">
                <label for="Sex">性別：</label>
                <asp:RadioButtonList ID="Sex" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="1">男</asp:ListItem>
                    <asp:ListItem Value="0">女</asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-6">
                <label for="Phone">電話1：</label>
                <input type="text" class="form-control" id="Phone1" runat="server" />
            </div>
            <div class="col-6">
                <label for="Phone">電話2：</label>
                <input type="text" class="form-control" id="Phone2" runat="server" />
            </div>
        </div>
        <div class="mb-3">
            <label for="Note">特別註記：</label>
            <input type="text" class="form-control" id="Note" runat="server" />
        </div>
        <div class="mb-3">
            <label for="Addr">住址：</label>
            <input type="text" class="form-control" id="Addr" runat="server" />
        </div>
        <div class="row mb-3">
            <div class="col-4">
                <asp:Button runat="server" ID="Serch" Text="查詢" CssClass="btn btn-primary" OnClick="Serch_Click" />
            </div>
            <div class="col-4">
                <asp:Button runat="server" ID="Clean" Text="清除" CssClass="btn btn-warning" OnClick="Clean_Click" />
            </div>
            <div class="col-4">
                <asp:Button runat="server" ID="Insert" Text="新增" CssClass="btn btn-danger" OnClick="Insert_Click" />
            </div>
        </div>
        <asp:ListView ID="ListView1" runat="server">
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color: #FFFBD6; color: #333333;">
                                    <th runat="server">病患編號</th>
                                    <th runat="server">姓名</th>
                                    <th runat="server">初診日期</th>
                                    <th runat="server">性別</th>
                                    <th runat="server">身份證字號</th>
                                    <th runat="server">出生年月</th>
                                    <th runat="server">電話</th>
                                    <th runat="server">通訊人地址</th>
                                    <th runat="server">特別記事</th>
                                    <th runat="server">動作</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="P_ID" runat="server" Text='<%# Eval("P_ID") %>' /></td>
                    <td>
                        <asp:Label ID="Name" runat="server" Text='<%# Eval("Name") %>' /></td>
                    <td>
                        <asp:Label ID="Firstvisit_Date" runat="server" Text='<%# Eval("Firstvisit_Date") %>' /></td>
                    <td>
                        <asp:Label ID="Sex" runat="server" Text='<%#checksex(Eval("Sex")) %>' /></td>
                    <td>
                        <asp:Label ID="identity" runat="server" Text='<%# Eval("identity") %>' /></td>
                    <td>
                        <asp:Label ID="Born_Date" runat="server" Text='<%# Eval("Born_Date") %>' /></td>
                    <td>
                        <asp:Label ID="Phone" runat="server" Text='<%# Eval("Phone") %>' /></td>
                    <td>
                        <asp:Label ID="addr" runat="server" Text='<%# Eval("addr") %>' /></td>
                    <td>
                        <asp:Label ID="Note" runat="server" Text='<%# Eval("Note") %>' /></td>
                    <td>
                        <asp:Button ID="update" runat="server" CssClass="btn btn-secondary" CommandArgument='<%# Eval("P_ID") %>' OnCommand="update_Click" Text="修改" />
                        <br />
                        <asp:Button ID="Serch" runat="server" CssClass="btn btn-info" CommandArgument='<%# Eval("P_ID") %>' Text="查詢病歷資料" />
                        <br />
                        <asp:Button ID="Delete" runat="server" CssClass="btn btn-danger" CommandArgument='<%# Eval("P_ID") %>' OnClientClick="Confirm()" OnCommand="Delete_Command" Text="刪除" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>


    </div>
</asp:Content>
