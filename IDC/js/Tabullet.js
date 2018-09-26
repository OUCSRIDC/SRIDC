/**
 * Created by Aditya on 2/22/2016.
 */
/// <reference path="../typings/browser/ambient/jquery/jquery.d.ts"/>
(function ($) {
    $.fn.tabullet = function (options) {
        var defaults = {
            rowClass: '',
            columnClass: '',
            tableClass: 'table',
            textClass: 'form-control',
            editClass: 'btn btn-default',
            deleteClass: 'btn btn-danger',
            saveClass: 'btn btn-success',
            deleteContent: 'Delete',
            editContent: 'Edit',
            saveContent: 'Save',
            action: function () {
            }
        };
        options = $.extend(defaults, options);
        var columns = $(this).find('thead > tr th');
        var idMap = $(this).find('thead > tr').first().attr('data-tabullet-map');
        var metadata = [];
        columns.each(function (i, v) {
            metadata.push({
                map: $(v).attr('data-tabullet-map'),
                readonly: $(v).attr('data-tabullet-readonly'),
                type: $(v).attr('data-tabullet-type')
            });
        });
        var index = 0;
        var data = options.data;
        $(data).each(function (i, v) {
            v._index = index++;
        });
        var table = this;
        $(table).find("tbody").remove();
        var tbody = $("<tbody/>").appendTo($(this));
        // INSERT
        var insertRow = $("<tr/>").appendTo($(tbody)).attr('data-tabullet-id', "-1");
        $(metadata).each(function (i, v) {
            if (v.type === 'delete') {
                var td = $("<td/>").appendTo(insertRow);
                return;
            }
            if (v.type === 'edit') {
                var td = $("<td/>")
                    .html('<button class="' + options.saveClass + '">' + options.saveContent + '</button>')
                    .attr('data-tabullet-type', 'save')
                    .appendTo(insertRow);
                td.find('button').click(function (event) {
                    var saveData = [];
                    var rowParent = td.closest('tr');
                    var rowChildren = rowParent.find('input');
                    $(rowChildren).each(function (ri, rv) {
                        saveData[$(rv).attr('name')] = $(rv).val();
                    });
                    options.action('save', saveData);
                    return;
                });
                return;
            }
            
            //给input一个id
            if (v.readonly !== 'true') {
                $('<td/>').html('<input type="text" name="' + v.map + '" class="' + options.textClass + '" id="save' + 2 + '"/>')
                    .appendTo(insertRow);
                $("tbody tr:first td:eq(1) input").attr('id','save1');
            }
            else {
                $("<td/>").appendTo(insertRow);
            }
        });
        $(data).each(function (i, v) {
            var tr = $("<tr/>").appendTo($(tbody)).attr('data-tabullet-id', v[idMap]);
            $(metadata).each(function (mi, mv) {
                //删除操作
                if (mv.type === 'delete') {
                    var td = $("<td/>")
                        .html('<button class="' + options.deleteClass + '">' + options.deleteContent + '</button>')
                        .attr('data-tabullet-type', mv.type)
                        .appendTo(tr);
                    td.find('button').click(function (event) {
                        //获取IP
                        var getip = $(this).parent('td').parent('tr').find('td').eq(1).html();
                        //console.log(getip);
                        tr.remove();
                        options.action('delete', $(tr).attr('data-tabullet-id'));
                        //删除数据
                        $.ajax({
                              type: "POST",
                              url: "api/info/delete.ashx",
                              data: { 
                                username: sessionStorage.getItem("NumberId"), 
                                ip: getip
                            },
                              async: false,
                              dataType: "json",
                              success: function (dat) {
                                  if (dat.Status == 200) {
                                      alert('删除成功！');
                                  }
                                  
                              }
                        });

                    });
                }

                //编辑操作
                else if (mv.type === 'edit') {
                    var td = $("<td/>")
                        .html('<button data-mode="nomal" class="' + options.editClass + '">' + options.editContent + '</button>')
                        .attr('data-tabullet-type', mv.type)
                        .appendTo(tr);
                    td.find('button').click(function (event) {
                        if ($(this).attr('data-mode') === 'edit') {
                            var editData = [];
                            var rowParent = td.closest('tr');
                            var rowChildren = rowParent.find('input');
                            $(rowChildren).each(function (ri, rv) {
                                editData[$(rv).attr('name')] = $(rv).val(); //获取当前的name属性
                            });
                            editData[idMap] = $(rowParent).attr('data-tabullet-id');
                            options.action('edit', editData);


                            return;
                        }

                        //edit点击后变成save
                        $(this).removeClass(options.editClass).addClass(options.saveClass).html(options.saveContent)
                            .attr('data-mode', 'edit');
                        //$(this).attr('id', 'editing');
                        var rowParent = td.closest('tr');
                        //$(rowParent).attr('id', 'eding');
                        var rowChildren = rowParent.find('td');
                        $(rowChildren).each(function (ri, rv) {
                            if ($(rv).attr('data-tabullet-type') === 'edit' ||
                                $(rv).attr('data-tabullet-type') === 'delete') {
                                return;
                            }

                            //锁定两条数据
                            var mapName = $(rv).attr('data-tabullet-map');  
                            if ($(rv).attr('data-tabullet-readonly') !== 'true') {
                                //显示编辑过的数据
                                $(rv).html('<input type="text" name="' + mapName + '" value="' + v[mapName] + '" class="' + options.textClass + '"/>');
                                var namename;
                                var nameip;
                                if($(rv).attr('data-tabullet-map') == 'name') {
                                    namename = $(rv).find('input').attr('value');
                                    console.log(namename);
                                }
                                if($(rv).attr('data-tabullet-map') == 'ip') {
                                    nameip = $(rv).find('input').attr('value');
                                    console.log(nameip);
                                }
                                //编辑数据
                                $.ajax({
                                      type: "POST",
                                      url: "api/info/change.ashx",
                                      data: { 
                                        username: sessionStorage.getItem("NumberId"), 
                                        ip: nameip,
                                        name: namename
                                    },
                                      async: false,
                                      dataType: "json",
                                      success: function (dat) {
                                          if (dat.Status == 200) {
                                              alert('修改成功！');
                                          }
                                          
                                      }
                                });

                            }
                        });
                    });
                }
                else {
                    var td = $("<td/>").html(v[mv.map])
                        .attr('data-tabullet-map', mv.map)
                        .attr('data-tabullet-readonly', mv.readonly)
                        .attr('data-tabullet-type', mv.type)
                        .appendTo(tr);
                }
            });

        });            
        //点击跳转
            var det = $("#table").children("tbody").children("tr").not(":first");
             det.each(function() {
                $(this).children("td").slice(0,3).click(function () {
                    var mm = $(this).parent("tr");
                    var mmd = $(mm).children("td").eq(3).find('button');
                    //点击时获取改行的id即ip
                    var ip = $(this).attr('data-tabullet-id');
                    //存入session，从detail页读取session
                    sessionStorage.setItem("hostip", ip);
                    console.log(this);
                    if($(mmd).attr('data-mode') == 'nomal'){
                        location.href = 'detail.html';
                    }
                    if($(mmd).attr('data-mode') == 'edit'){
                        console.log("eding");
                    }
                    //else{}
                });
            });
    };
}(jQuery));
