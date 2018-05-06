<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EditPatient.aspx.cs" Inherits="Medical_treatment.EditPatient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
            <div class="row">
                <div class="col-4 mb-1">
                    <label for="Name">姓名：</label>
                    <input type="text" class="form-control" id="Name" placeholder="姓名" runat="server"/>
                    <asp:RequiredFieldValidator ID="RFVNAME" runat="server" ErrorMessage="請輸入姓名" ForeColor="Red" ControlToValidate="Name"></asp:RequiredFieldValidator>
                </div>
                <div class="col-4 mb-1">
                    <label for="P_ID" runat="server">病歷編號：</label>
                    <input type="text" class="form-control" id="P_ID" placeholder="病歷編號" readonly="readonly" runat="server" />
                </div>
                <div class="col-4 mb-1">
                    <label for="identity">身分證字號：</label>
                    <input type="text" class="form-control" id="identity" placeholder="身分證字號：" runat="server" />
                    <asp:RequiredFieldValidator ID="RFVID" runat="server" ErrorMessage="請輸入身份證字號" ControlToValidate="identity" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-1">
                <div class="col-4">
                    <label for="Firstvisit_Date">初診日期：</label>
                    <input type="text" class="form-control" id="Firstvisit_Date" runat="server" />
                </div>
                <div class="col-4">
                    <label for="Born_Date">生日：</label>
                    <input type="text" class="form-control" id="Born_Date" runat="server" />
                    <asp:RequiredFieldValidator ID="RFVBD" runat="server" ErrorMessage="請填寫生日" ForeColor="Red" ControlToValidate="Born_Date"></asp:RequiredFieldValidator>
                </div>
                <div class="col-4">
                    <label for="Sex">性別：</label>
                    <asp:RadioButtonList ID="Sex" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="1">男</asp:ListItem>
                        <asp:ListItem Value="0">女</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="row mb-1">
                <div class="col-4">
                    <label for="Phone">電話：</label>
                    <input type="text" class="form-control" id="Phone" runat="server" />

                </div>
                <div class="col-8">
                    <label for="Note">特別註記：</label>
                    <input type="text" class="form-control" id="Note" runat="server" />
                </div>
            </div>
            <div class="mb-1">
                <label for="Addr">住址：</label>
                <input type="text" class="form-control" id="Addr" runat="server" />
                <asp:RequiredFieldValidator ID="RFVAddr" runat="server" ErrorMessage="請填寫住址" ForeColor="Red" ControlToValidate="Addr"></asp:RequiredFieldValidator>
            </div>
            <div class="row mb-1">
                <div class="col-6">
                    <asp:Button runat="server" ID="Update" Text="更新" CssClass="btn btn-success" OnClick="Update_Click" />
                </div>
                <div class="col-6">
                    <asp:Button runat="server" ID="Cancel" Text="取消" CssClass="btn btn-primary" OnClick="Cancel_Click" />
                </div>
            </div>
        </div>
</asp:Content>
