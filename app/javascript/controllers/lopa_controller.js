import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["output", "lopa_selected_seats", "seats"]

    // GLOBAL VARIABLE
    selected_seats = Array();
    drag_sel_seat = '';

    connect() {
        // Drag selection is currently disabled for mobile/tablet browsers.
        if (!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            // This function is used to select seat using mouse drag and drop
            this.drag_and_drop_seat_select();
        }

        this.resize_screen();
        window.addEventListener("resize", this.resize_screen);
        var controller_this = this;
        $("#fault_seats_impacted").click(function() {
            setTimeout(() => controller_this.setDefaultSelectedSeats(), 100);
        });
    }


    /*
        This function is used to select lopa seat
    */
    select_seats(e) {
        // single seat selection code
        var seat_id = e.target.getAttribute('id');
        var check_class = $("#" + seat_id).hasClass("select");
        if (this.drag_sel_seat != seat_id) {
            if (check_class) {
                this.remove_seats(seat_id);
            } else {
                this.add_seats(seat_id);
            }
            /*this function is used to set all selected seat in html text area*/
            this.sort_and_manage_selected_lopa_seats();
        }
        this.drag_sel_seat = '';
    }


    /*
        Display already selected sets on lopa for edit mode.
    */
    setDefaultSelectedSeats() {
        // clear all seat related information in lopa
        this.remove_all_selected_seats();
        // add selected seats in lopa
        this.selected_seats = Array();
        if (this.lopa_selected_seatsTarget.innerHTML != "") {
            var default_selected_seats = this.lopa_selected_seatsTarget.innerHTML.split(", ");
            for (var seatCnt = 0; seatCnt < default_selected_seats.length; seatCnt++) {
                this.add_seats(default_selected_seats[seatCnt]);
            }
        }
    }


    /*
        This function is used to select all lopa seats
    */
    select_all_seats(event) {
        event.preventDefault();
        this.selected_seats = Array();
        // Multiple seats selection code
        this.seatsTargets.forEach((e, i) => {
            var seat_id = e.getAttribute('id');
            this.add_seats(seat_id);
        });
        /*this function is used to set all selected seat in html text area*/
        this.sort_and_manage_selected_lopa_seats();
    }

    /*
        This function is used to deselect all lopa seats
    */
    deselect_all_seats(event) {
        event.preventDefault();
        this.selected_seats = Array();
        this.lopa_selected_seatsTarget.innerHTML = this.selected_seats;
        this.remove_all_selected_seats();
    }


    /* 
        This function is used to select lopa seats by drag and drop functionality
        Reference URL: http://threedubmedia.com/code/event/drop/demo/selection
    */
    drag_and_drop_seat_select() {
        var controller_this = this;
        var window_width = $(window).width();

        $("#lopa_container")
            .drag("start", function(ev, dd) {
                return $('<div class="selection" />')
                    .css('opacity', .65)
                    .appendTo($("#lopa_container"));
            })
            .drag(function(ev, dd) {
                if ($("#fault_seats_impacted").length) {
                    var x = ev.pageX - ($('.seats_impacted_modal').offset().left);
                    var x2 = dd.startX - ($('.seats_impacted_modal').offset().left);
                    var y = (ev.pageY - ($('.seats_impacted_modal').offset().top)) + $('.seats_impacted_modal').scrollTop();
                    var y2 = (dd.startY - ($('.seats_impacted_modal').offset().top)) + $('.seats_impacted_modal').scrollTop();
                } else {
                    var x = ev.pageX;
                    var y = ev.pageY;
                    var x2 = dd.startX;
                    var y2 = dd.startY;
                }
                $(dd.proxy).css({
                    top: Math.min(y, y2),
                    left: Math.min(x, x2),
                    height: Math.abs(ev.pageY - dd.startY),
                    width: Math.abs(ev.pageX - dd.startX)
                });
            })
            .drag("end", function(ev, dd) {
                $(dd.proxy).remove();
            });

        var temp_cnt = 0;
        $('.lopa__seat')
            .drop("start", function(ev) {
                temp_cnt++;
                $(this).addClass("active");
                var seat_id = $(this).attr("id");
                controller_this.drag_sel_seat = seat_id;
            })
            .drop(function(ev, dd) {
                var seat_id = $(this).attr("id");
                // prepend 0 if seat length is 2 like 1A, 2A for proper sorting of seats
                if (seat_id.length == 2) seat_id = '0' + seat_id;
                var check_class = $("#" + seat_id).hasClass("select");
                var index = controller_this.selected_seats.indexOf(seat_id);
                if (check_class == false) {
                    $(this).addClass("select");
                    if (index < 0) {
                        controller_this.add_seats(seat_id);
                        controller_this.sort_and_manage_selected_lopa_seats();
                    }
                } else if (temp_cnt == 1 && check_class == true) {
                    controller_this.remove_seats(seat_id);
                    controller_this.sort_and_manage_selected_lopa_seats();
                }
                temp_cnt = 0;
            })
            .drop("end", function(e) {
                $(this).removeClass("active");
            });
        $.drop({ multi: true });
    }


    /*
      Resize greed column on mobile view
    */
    resize_screen() {
        var window_width = $(window).width();
        $('#lopa_container > .lopa_deck').each(function() {
            var gridwidth = $(this).find('.lopa').attr('style');
            if (window_width <= 480) {
                gridwidth = gridwidth.replace(/30/g, 23);
            } else {
                gridwidth = gridwidth.replace(/23/g, 30);
            }
            $(this).find('.lopa').attr('style', gridwidth);
        });
    }



    /*
        remove all selected seats fom lopa
    */
    remove_all_selected_seats() {
        this.seatsTargets.forEach((e, i) => {
            var seat_id = e.getAttribute('id');
            e.classList.remove("select");
        });
    }


    /*
        This function is used to remove special char from string
    */
    remove_special_char_from_string(tmp_seat_array) {
        var strSeats = tmp_seat_array.split(", 0").join(", ");
        if (strSeats.charAt(0) === '0') strSeats = strSeats.substr(1);
        if (strSeats.charAt(0) === ',') strSeats = strSeats.substr(1);
        if (strSeats.charAt(0) === ' ') strSeats = strSeats.substr(1);
        return strSeats;
    }


    /*
        This function is used to add seat in global array to manage selected seats
    */
    add_seats(seat_id) {
        $("#" + seat_id).addClass("select");
        if (seat_id.length == 2) seat_id = '0' + seat_id;
        if (seat_id != "") {
            this.selected_seats.push(seat_id);
        }
    }


    /*
        This function is used to remove seat from global array to manage selected seats
    */
    remove_seats(seat_id) {
        $("#" + seat_id).removeClass("select");
        if (seat_id.length == 2) seat_id = '0' + seat_id;
        var index = this.selected_seats.indexOf(seat_id);
        if (index !== -1) this.selected_seats.splice(index, 1);
    }


    /*
        this function is used to set all selected seat in html text area
    */
    sort_and_manage_selected_lopa_seats() {
        var tempArrayOfSeats = this.selected_seats.sort(this.sortAlphaNum).join(", ");
        this.lopa_selected_seatsTarget.innerHTML = this.remove_special_char_from_string(tempArrayOfSeats);
    }


    /* 
        Set Sort Order of selected seates
    */
    sortAlphaNum(a, b) {
        var reA = /[^a-zA-Z]/g;
        var reN = /[^0-9]/g;
        var aN = parseInt(a.replace(reN, ""), 10);
        var bN = parseInt(b.replace(reN, ""), 10);
        if (aN === bN) {
            var aA = a.replace(reA, "");
            var bA = b.replace(reA, "");
            return aA > bA ? 1 : -1;
        } else {
            return aN === bN ? 0 : aN > bN ? 1 : -1;
        }
    }
}