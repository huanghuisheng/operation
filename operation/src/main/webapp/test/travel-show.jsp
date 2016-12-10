

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page pageEncoding="UTF-8"%> 

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="/WEB-INF/pages/view/yyskys/header.jsp">
            <jsp:param name="title" value="行车轨迹"/>
        </jsp:include>
    </head>
    <body>
        <div class="page-group">
            <div id="travel2" class="page">
                <div class="content">
                    <div class="locate2-box">
                        <div class="locate2-success">
                            <div id="bmap"></div>
                            <div class="address">
                                <p class="time">
                                    <fmt:formatDate value="${stTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    --
                                    <fmt:formatDate value="${edTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                               	</p>
                                <div class="address-info">
                                    <p>${stAddr}~${edAddr}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        var points = [];
                        <c:forEach items="${resultList}" var="data">
                            <c:if test="${data.type==1}">
                                points.push(new BMap.Point(${data.clng}, ${data.clat}));
                            </c:if>
                        </c:forEach>

                        function TrackLoader(points) {
                            this.points = points;
                            this.load = function () {
                                this.map = new BMap.Map("bmap");
                                this.map.setMinZoom(7);
                                this.map.setMaxZoom(17);
                                this.map.enableScrollWheelZoom();

                                var polyline = new BMap.Polyline(this.points, {
                                    strokeColor: "red",
                                    strokeWeight: 4,
                                    strokeOpacity: 0.5
                                });

                                this.map.addOverlay(polyline);
                            }
                            this.addStart = function () {
                                var icon = new BMap.Icon("${staticResUrl}/images/bubble_start.png", new BMap.Size(48, 48), {anchor: new BMap.Size(24, 48)});
                                var marker = new BMap.Marker(this.points[0], {icon: icon});
                                this.map.addOverlay(marker);
                            }
                            this.addFinish = function () {
                                var icon = new BMap.Icon("${staticResUrl}/images/bubble_end.png", new BMap.Size(48, 48), {anchor: new BMap.Size(24, 48)});
                                var marker = new BMap.Marker(this.points[this.points.length - 1], {icon: icon});
                                this.map.addOverlay(marker);
                            }
                            this.center = function () {
                                var p = this.points[0];
                                this.map.centerAndZoom(new BMap.Point(p.lng, p.lat), 14);
                            }
                        }
                        $(function () {
                            $(document).on("pageInit", "#travel2", function (e, id, page) {
                                var track = new TrackLoader(points);
                                track.load();
                                track.addStart();
                                track.addFinish();
                                track.center();
                            });
                            $.init();
                        });
                    </script>
                </div>
            </div>
        </div>

        <%-- 页脚 --%>
        <jsp:include page="/WEB-INF/pages/view/yyskys/footer.jsp"/>
    </body>

</html>