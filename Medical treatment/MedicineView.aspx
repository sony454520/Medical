<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MedicineView.aspx.cs" Inherits="Medical_treatment.MedicineView" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--<link href="Content/bootstrap-4.1.0.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-treeview.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/jquery-ui.min.js"></script>
    <script src="Scripts/bootstrap-4.1.0.min.js"></script>-->
    <script src="Scripts/bootstrap-treeview.min.js"></script>
    <title></title>
    <script type="text/javascript">
        $(function () {
            var defaultData = [
                {
                    text: 'Parent 1',
                    href: '#parent1',
                    tags: ['4'],
                    nodes: [
                        {
                            text: 'Child 1',
                            href: '#child1',
                            tags: ['2'],
                            nodes: [
                                {
                                    text: 'Grandchild 1',
                                    href: '#grandchild1',
                                    tags: ['0']
                                },
                                {
                                    text: 'Grandchild 2',
                                    href: '#grandchild2',
                                    tags: ['0']
                                }
                            ]
                        },
                        {
                            text: 'Child 2',
                            href: '#child2',
                            tags: ['0']
                        }
                    ]
                },
                {
                    text: 'Parent 2',
                    href: '#parent2',
                    tags: ['0']
                },
                {
                    text: 'Parent 3',
                    href: '#parent3',
                    tags: ['0']
                },
                {
                    text: 'Parent 4',
                    href: '#parent4',
                    tags: ['0']
                },
                {
                    text: 'Parent 5',
                    href: '#parent5',
                    tags: ['0']
                }
            ];
            $('#treeview2').treeview({
                levels: 1,
                data: defaultData
            });
            $('.fancybox-content').height($('#treeview2').height());
        });
    </script>
</head>
<body>
    <h3>處方編輯</h3>    
    <div id="treeview2" class="treeview"></div>
    <input type="text" id="tt" class="form-control" />
</body>
</html>
