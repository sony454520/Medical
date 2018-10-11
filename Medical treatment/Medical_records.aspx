<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Medical_records.aspx.cs" Inherits="Medical_treatment.Medical_records1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="Scripts/bootstrap-treeview.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {            
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
                $('#ContentPlaceHolder1_PH_ID').val($(this).val());
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
            $('#btn_addmail').click(function(){
                window.open("Mail_records.aspx?p_id="+$('#ContentPlaceHolder1_P_ID').html(),'列印收據');
            });
            
            if ($('#ContentPlaceHolder1_PH_ID').val() != "") {
                $('.ph_id[value='+$('#ContentPlaceHolder1_PH_ID').val() +']').click();
            }

            //病因            
            var WoundAData = [
                {
                    text: '全身骨骼',
                    nodes: [
                        { text: '頭部', nodes: [{ text: '前額骨' }, { text: '眼窩骨' }, { text: '面觀骨' }, { text: '上頜骨' }, { text: '下頜骨' }, { text: '頜關節' }] },
                        { text: '頸部', nodes: [{ text: '頸椎骨' }, { text: '頸椎關節' }] },
                        { text: '肩部', nodes: [{ text: '鎖骨' }, { text: '鎖骨關節' }, { text: '肩胛骨' }, { text: '肩關節' }] },
                        { text: '胸部', nodes: [{ text: '胸骨' }, { text: '肋骨' }] },
                        { text: '腹部', nodes: [{ text: '髖骨' }, { text: '坐骨' }, { text: '股關節' }] },
                        { text: '手', nodes: [{ text: '肱骨' }, { text: '肘關節' }, { text: '橈骨' }, { text: '尺骨' }, { text: '腕骨' }, { text: '手腕關節' }, { text: '掌骨' }, { text: '指骨' }, { text: '指關節' }] },
                        { text: '腿', nodes: [{ text: '股骨' }, { text: '髕骨(膝蓋骨)' }, { text: '髕骨關節' }, { text: '膝關節' }, { text: '脛骨' }, { text: '腓骨' }, { text: '跗骨' }, { text: '蹠骨' }, { text: '趾骨' }, { text: '踝關節' }, { text: '跗骨' }, { text: '後跟骨' }] },
                        { text: '腰部' },
                        { text: '腳' }
                    ]                  
                }
            ];            
            var WoundBData = [{ text: '肌肉' }, { text: '筋' }, { text: '關節' }, { text: '骨骼' }];
            var WoundCData = [{ text: '挫傷' }, { text: '扭傷' }, { text: '骨折' }, { text: '瘀血' }, { text: '脫臼' }, { text: '骨折後復建' }];
            $('#treeview_WoundA').treeview({ levels: 2, data: WoundAData });
            $('#treeview_WoundB').treeview({ levels: 1, data: WoundBData });
            $('#treeview_WoundC').treeview({levels: 1,data: WoundCData});            
            $('#treeview_WoundA,#treeview_WoundB,#treeview_WoundC').on('nodeSelected', function (event, node) {
                $('#Wound_txt').val($('#Wound_txt').val() + node.text);
            });         
            $('#ContentPlaceHolder1_Wound').focus(function () {                
                $('#Wound_txt').val($(this).val());                
                $('.fancybox-content').height($('#treeview_Wound').height());                
            })
            $('#Wound_btn').click(function () {
                $('#ContentPlaceHolder1_Wound').val($('#Wound_txt').val());
                $.fancybox.close();
            });
            //處方
            var medicineData = [{ text: '開立收據' },{ text: '泡熱水' },{ text: '開立請假證明' },{ text: '8日拆' },{ text: '暫未貼' },{text: '貼薑餅'},{text: '按摩膏3.0*1'},{text: '燻6.0*1 按摩膏3.0*2'}, {text: '推拿'},{text: '燻6.0*1'}];
            $('#treeview_medicine').treeview({levels: 1,data: medicineData});
            $('#treeview_medicine') .on('nodeSelected', function (event, node) {
                $('#medicine_txt').val($('#medicine_txt').val() + node.text);
            });
            $('#ContentPlaceHolder1_medicine').focus(function () {
                $('.fancybox-content').height($('#treeview_medicine').height());
                $('#medicine_txt').val($(this).val());
            })
            $('#medicine_btn').click(function () {
                $('#ContentPlaceHolder1_medicine').val($('#medicine_txt').val());
                $.fancybox.close();
            });
        });        

        
    </script>
    <h3>病歷資料(<span class="foo"><asp:Label ID="FullName" runat="server"></asp:Label></span>)</h3>
    <button id="btn_addmail" type="button" class="btn btn-sm btn-info">
        <span class="glyphicon glyphicon-envelope"></span> 郵寄資料
    </button>
    <br />
    <div id="show_data" >
        <asp:ListView ID="ListView1" runat="server">
         <LayoutTemplate>
            <table id="my_table" class="table table-striped table-bordered" style="width:100%">
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
        <asp:Label runat="server" ID="P_ID"   />
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
            <input type="text" class="form-control Wound" data-fancybox  data-src="#div_Wound" runat="server" id="Wound" />
        </div>
        <div class="mb-2">
            <label for="Medicine">處方</label>
            <input type="text" class="form-control medicine fancy" data-fancybox  data-src="#div_medicine"  runat="server" id="medicine" />
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

    <div style="display: none;width:60%" id="div_Wound">
	   <h3>症狀選擇</h3>    
       <table style="width:100%">
           <tr>
               <td rowspan="2">
                    <div style="height:400px;overflow: auto;">
                        <div id="treeview_WoundA" class="treeview"></div>
                    </div>
               </td>
               <td>
                   <div style="height:200px;overflow: auto;">
                        <div id="treeview_WoundB" class="treeview"></div>
                    </div>
               </td>
           </tr>
          <tr>
              <td>
                   <div style="height:200px;overflow: auto;">
                        <div id="treeview_WoundC" class="treeview"></div>
                    </div>
               </td>
          </tr>
       </table>        
        <div class="btn btn-primary">左</div>　
        <div class="btn btn-primary">右</div><br /><br />
       <input type="text" id="Wound_txt" class="form-control" />
        <br />
        <div id="Wound_btn" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 確定</div>
    </div>

    <div style="display: none;width:50%" id="div_medicine">
	   <h3>藥物名稱</h3>    
        <div style="height:300px;overflow: auto;">
            <div id="treeview_medicine" class="treeview"></div>
        </div>
       <input type="text" id="medicine_txt" class="form-control" />
        <br />
        <div id="medicine_btn" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 確定</div>
    </div>
</asp:Content>
