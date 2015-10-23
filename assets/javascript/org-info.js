function OrgNode(e, h, f, g, d, b, j) {
    var i = this;
    i.D = e;
    i.I = b;
    i.J = -1;
    i.H = h;
    i.L = f;
    i.HH = false;
    i.P = d;
    i.DRT = false;
    i.ST = OrgNode.SF;
    i.TOC = j;
    i.DEPTH = g;
    i.F = null;
    i.CH = new Array();
    i.NAV = "";
    i.BS = null;
    if (null != i.P) {
        i.P.addChild(this);
        i.hide();
    }
    var a = document.getElementById("text-" + i.I);
    if (null == a && b) {
        var c = b.substring(4);
        a = document.getElementById("text-" + c);
    }
    if (null != a) {
        i.F = a;
    }
    i.iTF = new Object();
    i.iTF["#" + i.I] = 2;
    OrgNode.fTI(i.iTF, i.H, 1);
    OrgNode.fTI(i.iTF, i.F, 3);
}
OrgNode.SF = 0;
OrgNode.SH = 1;
OrgNode.SU = 2;
OrgNode.fTI = function(f, c, e) {
    if (c) {
        var b = c.getElementsByTagName("a");
        if (b) {
            for (var d = 0; d < b.length; ++d) {
                var g = b[d].getAttribute("id");
                if (g) {
                    f["#" + g] = e;
                } else {
                    g = b[d].getAttribute("name");
                    if (g) {
                        f["#" + g] = e;
                    }
                }
            }
        }
    }
};
OrgNode.hE = function(a) {
    if (a && a.style) {
        a.style.display = "none";
        a.style.visibility = "hidden";
    }
};
OrgNode.sE = function(a) {
    if (a && a.style) {
        a.style.display = "block";
        a.style.visibility = "visible";
    }
};
OrgNode.uhE = function(a) {
    a.style.display = "";
    a.style.visibility = "";
};
OrgNode.isHidden = function(a) {
    if (a.style.display == "none" || a.style.visibility == "hidden") {
        return true;
    }
    return false;
};
OrgNode.toggleElement = function(a) {
    if (a.style.display == "none") {
        a.style.display = "block";
        a.style.visibility = "visible";
    } else {
        a.style.display = "none";
        a.style.visibility = "hidden";
    }
};
OrgNode.textNodeToIdx = function(b, c) {
    while (b.nodeType != 1 || -1 == b.attributes.id.value.indexOf("outline-container-")) {
        b = b.parentNode;
    }
    var a = b.attributes.id.value.substr(18);
    return OrgNode.idxForBaseId(a, c);
};
OrgNode.idxForBaseId = function(b, d) {
    if (d.I == b) {
        return d;
    }
    for (var a = 0; a < d.CH.length; ++a) {
        var c = OrgNode.idxForBaseId(idx, d.CH[a]);
        if (null != c) {
            return c;
        }
    }
    return null;
};
OrgNode.prototype.addChild = function(a) {
    this.CH.push(a);
    return this.P;
};
OrgNode.prototype.hide = function() {
    OrgNode.hE(this.D);
    if (this.P) {
        this.P.hide();
    }
};
OrgNode.prototype.show = function() {
    OrgNode.sE(this.D);
    if (this.DEPTH > 2) {
        this.P.show();
    }
};
OrgNode.prototype.sAC = function() {
    for (var a = 0; a < this.CH.length; ++a) {
        this.CH[a].sAC();
    }
    this.show();
};
OrgNode.prototype.hAC = function() {
    for (var a = 0; a < this.CH.length; ++a) {
        this.CH[a].hAC();
    }
    this.hide();
};
OrgNode.prototype.setLinkClass = function(a) {
    if (this.TOC) {
        if (a) {
            this.TOC.className = "current";
        } else {
            this.TOC.className = "visited_after_load";
        }
    }
};
OrgNode.prototype.fold = function(b) {
    if (this.P) {
        this.P.DRT = true;
    }
    if (this.DRT) {
        this.DRT = false;
        this.ST = OrgNode.SU;
    }
    if (null != this.F) {
        if (this.ST == OrgNode.SF) {
            if (this.CH.length) {
                this.ST = OrgNode.SH;
                OrgNode.hE(this.F);
                for (var a = 0; a < this.CH.length; ++a) {
                    this.CH[a].sSt(OrgNode.SH);
                }
            } else {
                if (!b) {
                    this.ST = OrgNode.SU;
                    OrgNode.sE(this.F);
                }
            }
        } else {
            if (this.ST == OrgNode.SH) {
                this.ST = OrgNode.SU;
                OrgNode.sE(this.F);
                for (var a = 0; a < this.CH.length; ++a) {
                    this.CH[a].sSt(OrgNode.SU);
                }
            } else {
                this.ST = OrgNode.SF;
                OrgNode.hE(this.F);
                for (var a = 0; a < this.CH.length; ++a) {
                    this.CH[a].sSt(OrgNode.SF);
                }
            }
        }
    }
};
OrgNode.prototype.sSt = function(c) {
    var b = this;
    for (var a = 0; a < b.CH.length; ++a) {
        b.CH[a].sSt(c);
    }
    switch (c) {
        case OrgNode.SF:
            OrgNode.hE(b.F);
            OrgNode.hE(b.D);
            break;
        case OrgNode.SH:
            OrgNode.hE(b.F);
            OrgNode.sE(b.D);
            break;
        default:
            OrgNode.sE(b.F);
            OrgNode.sE(b.D);
    }
    b.ST = c;
};
var org_html_manager = {
    MOUSE_HINT: 0,
    B: null,
    PLAIN_VIEW: 0,
    CONTENT_VIEW: 1,
    ALL_VIEW: 2,
    INFO_VIEW: 3,
    SLIDE_VIEW: 4,
    VIEW: this.CONTENT_VIEW,
    LOCAL_TOC: false,
    LINK_HOME: 0,
    LINK_UP: 0,
    LINKS: "",
    RUN_MAX: 1200,
    RUN_INTERVAL: 100,
    HIDE_TOC: false,
    TOC_DEPTH: 0,
    STARTUP_MESSAGE: 0,
    P: null,
    BU: document.URL,
    Q: "",
    R: null,
    N: null,
    T: null,
    IT: false,
    LOAD_CHECK: null,
    W: null,
    S: new Array(),
    REGEX: /(#)(.*$)/,
    SIDX: /(^#)(sec-\d+([._]\d+)*$)/,
    UNTAGX: /<[^>]+>/i,
    ORGTAGX: /^(.*)<span\s+class=[\'\"]tag[\'\"]>(<span[^>]+>[^<]+<\/span>)+<\/span>/i,
    TRIMMER: /^(\s*)([^\s].*)(\s*)$/,
    TOC: null,
    RUNS: 0,
    H: new Array(50),
    HI: 0,
    SKIP_H: false,
    FIXED_TOC: false,
    C: null,
    CI: null,
    CL: null,
    CO: "50px",
    OCCUR: "",
    SCX: "",
    SC_HLX: new RegExp('(<span class="org-info-js_search-highlight">)([^<]*?)(</span>)', "gi"),
    Mg: 0,
    MgI: 1,
    MgT: 2,
    Hg: false,
    Rg: false,
    RC: "",
    RC_NULL: "_0",
    RC_H: "_1",
    RC_O: "_2",
    RC_P: "_03",
    LVM: 0,
    TAB_INDEX: 1000,
    SHO: false,
    TAGS: {},
    ST: new Array(),
    TAGS_INDEX: null,
    CTO: null,
    SN_MAP: {},
    TL: null,
    HOOKS: {
        run_hooks: false,
        onShowSection: [],
        onReady: []
    },
    setup: function() {
        var d = this;
        if (window.orgInfoHooks) {
            for (var c in orgInfoHooks) {
                d.HOOKS[c] = orgInfoHooks[c];
            }
            d.HOOKS.run_hooks = false;
        }
        if (location.search) {
            var e = location.search.substring(1).split("&");
            for (var c = 0; c < e.length;
                ++c) {
                var f = e[c].indexOf("=");
                if (-1 != f) {
                    var b = e[c].substring(f + 1);
                    var a = e[c].substring(0, f);
                    switch (a) {
                        case "TOC":
                        case "TOC_DEPTH":
                        case "MOUSE_HINT":
                        case "HELP":
                        case "VIEW":
                        case "HIDE_TOC":
                        case "LOCAL_TOC":
                        case "OCCUR":
                            d.set(a, decodeURIComponent(b));
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        d.VIEW = d.VIEW ? d.VIEW : d.PLAIN_VIEW;
        d.VIEW_BUTTONS = (d.VIEW_BUTTONS && d.VIEW_BUTTONS != "0") ? true : false;
        d.STARTUP_MESSAGE = (d.STARTUP_MESSAGE && d.STARTUP_MESSAGE != "0") ? true : false;
        d.LOCAL_TOC = (d.LOCAL_TOC && d.LOCAL_TOC != "0") ? d.LOCAL_TOC : false;
        d.HIDE_TOC = (d.TOC && d.TOC != "0") ? false : true;
        d.IT = (d.IT && d.IT != "title_above") ? false : true;
        if (d.FIXED_TOC && d.FIXED_TOC != "0") {
            d.FIXED_TOC = true;
            d.HIDE_TOC = false;
        } else {
            d.FIXED_TOC = false;
        }
        d.LINKS += ((d.LINK_UP && d.LINK_UP != document.URL) ? '<a href="' + d.LINK_UP + '">Up</a> / ' : "") + ((d.LINK_HOME && d.LINK_HOME != document.URL) ? '<a href="' + d.LINK_HOME + '">HOME</a> / ' : "") + '<a href="javascript:org_html_manager.showHelp();">HELP</a> / ';
        d.LOAD_CHECK = window.setTimeout("OrgHtmlManagerLoadCheck()", 50);
    },
    trim: function(a) {
        var b = this.TRIMMER.exec(a);
        return RegExp.$2;
    },
    rT: function(a) {
        if (a) {
            while (a.match(this.UNTAGX)) {
                a = a.substr(0, a.indexOf("<")) + a.substr(a.indexOf(">") + 1);
            }
        }
        return a;
    },
    rOT: function(a) {
        if (a.match(this.ORGTAGX)) {
            var b = this.ORGTAGX.exec(a);
            return b[1];
        }
        return a;
    },
    init: function() {
        var m = this;
        m.RUNS++;
        m.B = document.getElementById("content");
        if (null == m.B) {
            if (5 > m.RUNS) {
                m.LOAD_CHECK = window.setTimeout("OrgHtmlManagerLoadCheck()", m.RUN_INTERVAL);
                return;
            } else {
                m.B = document.getElementsByTagName("body")[0];
            }
        }
        if (!m.W) {
            m.W = document.createElement("div");
            m.W.style.marginBottom = "40px";
            m.W.id = "org-info-js-window";
        }
        var l = document.getElementById("table-of-contents");
        if (!m.initFromTOC()) {
            if (m.RUNS < m.RUN_MAX) {
                m.LOAD_CHECK = window.setTimeout("OrgHtmlManagerLoadCheck()", m.RUN_INTERVAL);
                return;
            }
        }
        var d = 0;
        var f = false;
        if ("" != location.hash) {
            m.BU = m.BU.substring(0, m.BU.indexOf("#"));
            for (var e = 0; e < m.S.length; ++e) {
                if (m.S[e].iTF[location.hash]) {
                    d = e;
                    f = 1;
                    break;
                }
            }
        }
        if ("" != location.search) {
            m.Q = m.BU.substring(m.BU.indexOf("?"));
            m.BU = m.BU.substring(0, m.BU.indexOf("?"));
        }
        m.convertLinks();
        var j = document.getElementById("postamble");
        if (j) {
            m.P = j;
        }
        var h = m.B;
        var c = h.firstChild;
        if (3 == c.nodeType) {
            var g = c.cloneNode(true);
            var a = document.createElement("p");
            a.id = "text-before-first-headline";
            a.appendChild(g);
            h.replaceChild(a, c);
        }
        m.C = document.createElement("div");
        m.C.innerHTML = '<form action="" style="margin:0px;padding:0px;" onsubmit="org_html_manager.eRC(); return false;"><table id="org-info-js_console" style="width:100%;margin:0px 0px 0px 0px;border-style:none;" cellpadding="0" cellspacing="0" summary="minibuffer"><tbody><tr><td id="org-info-js_console-icon" style="padding:0px 0px 0px 0px;border-style:none;">&#160;</td><td style="width:100%;vertical-align:middle;padding:0px 0px 0px 0px;border-style:none;"><table style="width:100%;margin:0px 0px 0px 0px;border-style:none;" cellpadding="0" cellspacing="2"><tbody><tr><td id="org-info-js_console-label" style="white-space:nowrap;padding:0px 0px 0px 0px;border-style:none;"></td></tr><tr><td style="width:100%;vertical-align:middle;padding:0px 0px 0px 0px;border-style:none;"><input type="text" id="org-info-js_console-input" onkeydown="org_html_manager.getKey();" onclick="this.select();" maxlength="150" style="width:100%;padding:0px;margin:0px 0px 0px 0px;border-style:none;" value=""/></td></tr></tbody></table></td><td style="padding:0px 0px 0px 0px;border-style:none;">&#160;</td></tr></tbody></table></form>';
        m.C.style.position = "relative";
        m.C.style.marginTop = "-" + m.CO;
        m.C.style.top = "-" + m.CO;
        m.C.style.left = "0px";
        m.C.style.width = "100%";
        m.C.style.height = "40px";
        m.C.style.overflow = "hidden";
        m.C.style.verticalAlign = "middle";
        m.C.style.zIndex = "9";
        m.C.style.border = "0px solid #cccccc";
        m.C.id = "org-info-js_console-container";
        m.B.insertBefore(m.C, m.B.firstChild);
        m.Mg = false;
        m.CL = document.getElementById("org-info-js_console-label");
        m.CI = document.getElementById("org-info-js_console-input");
        document.onkeypress = OrgHtmlManagerKeyEvent;
        if (m.VIEW == m.INFO_VIEW) {
            m.iV(d);
            m.ss(d);
            window.setTimeout(function() {
                window.scrollTo(0, 0);
            }, 100);
        } else {
            if (m.VIEW == m.SLIDE_VIEW) {
                m.sV(d);
                m.ss(d);
            } else {
                var k = m.VIEW;
                m.pV(d, 1);
                m.R.DRT = true;
                m.R_STATE = OrgNode.SU;
                m.tG();
                if (k > m.PLAIN_VIEW) {
                    m.tG();
                }
                if (k == m.ALL_VIEW) {
                    m.tG();
                }
                if (f) {
                    m.ss(d);
                }
            }
        }
        if ("" != m.OCCUR) {
            m.CI.value = m.OCCUR;
            m.RC = "o";
            m.eRC();
        }
        if (m.STARTUP_MESSAGE) {
            m.warn("This page uses org-info.js. Press '?' for more information.", true);
        }
        m.HOOKS.run_hooks = true;
        m.runHooks("onReady", this.N);
    },
   initFromTOC: function() {
        var k = this;
        if (k.RUNS == 1 || !k.R) {
            var b = document.getElementById("table-of-contents");
            if (null != b) {
                var m = null;
                var d = 0;
                for (d; m == null && d < 7; ++d) {
                    m = b.getElementsByTagName("h" + d)[0];
                }
                m.onclick = function() {
                    org_html_manager.fold(0);
                };
                m.style.cursor = "pointer";
                if (k.MOUSE_HINT) {
                    m.onmouseover = function() {
                        org_html_manager.hH(0);
                    };
                    m.onmouseout = function() {
                        org_html_manager.unhH(0);
                    };
                }
                if (k.FIXED_TOC) {
                    m.setAttribute("onclick", "org_html_manager.tG();");
                    k.R = new OrgNode(null, k.B.getElementsByTagName("h1")[0], "javascript:org_html_manager.go(0);", 0, null);
                    k.TOC = new OrgNode(b, m, "javascript:org_html_manager.go(0);", d, null);
                    k.N = k.R;
                } else {
                    k.R = new OrgNode(null, k.B.getElementsByTagName("h1")[0], "javascript:org_html_manager.go(0);", 0, null);
                    if (k.HIDE_TOC) {
                        k.TOC = new OrgNode(b, "", "javascript:org_html_manager.go(0);", d, null);
                        k.N = k.R;
                        OrgNode.hE(b);
                    } else {
                        k.TOC = new OrgNode(b, m, "javascript:org_html_manager.go(0);", d, k.R);
                        k.TOC.J = 0;
                        k.N = k.TOC;
                        k.S.push(k.TOC);
                    }
                }
                if (k.TOC) {
                    k.TOC.F = document.getElementById("text-table-of-contents");
                }
            } else {
                return false;
            }
        }
        var j = k.TOC.F.getElementsByTagName("ul")[0];
        if (!k.ulToOutlines(j)) {
            return false;
        }
        var h = document.getElementById("footnotes");
        if (h) {
            var a = null;
            var f = h.childNodes;
            for (var d = 0; d < f.length; ++d) {
                if ("footnotes" == f[d].className) {
                    a = f[d];
                    break;
                }
            }
            var e = k.S.length;
            a.onclick = function() {
                org_html_manager.fold("" + e);
            };
            a.style.cursor = "pointer";
            if (k.MOUSE_HINT) {
                a.onmouseover = function() {
                    org_html_manager.hH("" + e);
                };
                a.onmouseout = function() {
                    org_html_manager.unhH("" + e);
                };
            }
            var g = "javascript:org_html_manager.go(" + e + ")";
            var l = new OrgNode(h, a, g, 1, k.R, "footnotes");
            k.S.push(l);
        }
        if (k.TOC_DEPTH) {
            k.cutToc(j, 1);
        }
        k.T = k.B.getElementsByTagName("h1")[0];
        if (k.IT && !k.FIXED_TOC && k.VIEW != k.SLIDE_VIEW) {
            k.IT = k.T.cloneNode(true);
            k.S[0].D.insertBefore(k.IT, k.S[0].D.firstChild);
            OrgNode.hE(k.T);
        }
        k.build();
        k.N = k.S[0];
        k.B.insertBefore(k.W, k.N.D);
        return true;
    },
    ulToOutlines: function(b) {
        if (b.hasChildNodes() && !b.scanned_for_org) {
            for (var a = 0; a < b.childNodes.length; ++a) {
                if (false == this.liToOutlines(b.childNodes[a])) {
                    return false;
                }
            }
            b.scanned_for_org = 1;
        }
        return true;
    },
    liToOutlines: function(b) {
        if (!b.scanned_for_org) {
            for (var d = 0; d < b.childNodes.length; ++d) {
                var e = b.childNodes[d];
                switch (e.nodeName) {
                    case "A":
                        var a = this.mkNodeFromHref(e);
                        if (false == a) {
                            return false;
                        } else {
                            e.href = a;
                            e.tabIndex = this.TAB_INDEX;
                            e.onfocus = function() {
                                org_html_manager.TL = this;
                                void 0;
                            };
                            if (null == this.TL) {
                                this.TL = e;
                            }
                            this.TAB_INDEX++;
                        }
                        break;
                    case "UL":
                        return this.ulToOutlines(e);
                        break;
                }
            }
            b.scanned_for_org = 1;
        }
        return true;
    },
    cutToc: function(e, f) {
        f++;
        if (e.hasChildNodes()) {
            for (var d = 0; d < e.childNodes.length; ++d) {
                var a = e.childNodes[d];
                for (var b = 0; b < a.childNodes.length;
                    ++b) {
                    var g = a.childNodes[b];
                    if (g.nodeName == "UL") {
                        if (f > this.TOC_DEPTH) {
                            a.removeChild(g);
                        } else {
                            this.cutToc(g, f);
                        }
                    }
                }
            }
        }
    },
    mkNodeFromHref: function(g) {
        s = g.href;
        if (s.match(this.REGEX)) {
            var k = this.REGEX.exec(s);
            var c = k[2];
            var l = document.getElementById(c);
            if (null == l) {
                return (false);
            }
            var a = l.parentNode;
            var m = this.S.length;
            var f = a.className.substr(8);
            l.onclick = function() {
                org_html_manager.fold("" + m);
            };
            l.style.cursor = "pointer";
            if (this.MOUSE_HINT) {
                l.onmouseover = function() {
                    org_html_manager.hH("" + m);
                };
                l.onmouseout = function() {
                    org_html_manager.unhH("" + m);
                };
            }
            var o = "javascript:org_html_manager.go(" + m + ")";
            if (f > this.N.DEPTH) {
                this.N = new OrgNode(a, l, o, f, this.N, c, g);
            } else {
                if (f == 2) {
                    this.N = new OrgNode(a, l, o, f, this.R, c, g);
                } else {
                    var b = this.N;
                    while (b.DEPTH > f) {
                        b = b.P;
                    }
                    this.N = new OrgNode(a, l, o, f, b.P, c, g);
                }
            }
           this.S.push(this.N);
            var n = l.getElementsByTagName("span");
            if (n) {
                for (var e = 0; e < n.length; ++e) {
                    if (n[e].className == "tag") {
                        var r = n[e].innerHTML.split("&nbsp;");
                        for (var d = 0; d < r.length; ++d) {
                            var q = this.rT(r[d]);
                            if (!this.TAGS[q]) {
                                this.TAGS[q] = new Array();
                                this.ST.push(q);
                            }
                            this.TAGS[q].push(m);
                        }
                    } else {
                        if (n[e].className.match(this.SECNUMX)) {
                            this.SN_MAP[this.trim(n[e].innerHTML)] = this.N;
                        }
                    }
                }
            }
            this.N.hide();
            return (o);
        }
        return (s);
    },
    build: function() {
        var f = this.T.innerHTML;
        var e = 0;
        for (var d = 0; d < this.S.length; ++d) {
            this.S[d].J = d;
            var c = '<table class="org-info-js_info-navigation" width="100%" border="0" style="border-bottom:1px solid black;"><tr><td colspan="3" style="text-align:left;border-style:none;vertical-align:bottom;"><span style="float:left;display:inline;text-align:left;">Top: <a accesskey="t" href="javascript:org_html_manager.go(0);">' + f + '</a></span><span style="float:right;display:inline;text-align:right;font-size:70%;">' + this.LINKS + '<a accesskey="m" href="javascript:org_html_manager.toggleView(' + d + ');">toggle view</a></span></td></tr><tr><td style="text-align:left;border-style:none;vertical-align:bottom;width:22%">';
            if (d > 0) {
                c += '<a accesskey="p" href="' + this.S[d - 1].L + '" title="Go to: ' + this.rT(this.S[d - 1].H.innerHTML) + '">Previous</a> | ';
            } else {
                c += "Previous | ";
            }
            if (d < this.S.length - 1) {
                c += '<a accesskey="n" href="' + this.S[d + 1].L + '" title="Go to: ' + this.rT(this.S[d + 1].H.innerHTML) + '">Next</a>';
            } else {
                c += "Next";
            }
            c += '</td><td style="text-align:center;vertical-align:bottom;border-style:none;width:56%;">';
            if (d > 0 && this.S[d].P.P) {
                c += '<a href="' + this.S[d].P.L + '" title="Go to: ' + this.rT(this.S[d].P.H.innerHTML) + '"><span style="font-variant:small-caps;font-style:italic;">' + this.S[d].P.H.innerHTML + "</span></a>";
            } else {
                c += '<span style="font-variant:small-caps;font-style:italic;">' + this.S[d].H.innerHTML + "</span>";
            }
            c += '</td><td style="text-align:right;vertical-align:bottom;border-style:none;width:22%">';
            c += (d + 1) + "</td></tr></table>";
            this.S[d].BS = document.createElement("div");
            this.S[d].BS.innerHTML = '<div class="org-info-js_header-navigation" style="display:inline;float:right;text-align:right;font-size:70%;font-weight:normal;">' + this.LINKS + '<a accesskey="m" href="javascript:org_html_manager.toggleView(' + d + ');">toggle view</a></div>';
            if (this.S[d].F) {
                this.S[d].D.insertBefore(this.S[d].BS, this.S[d].H);
            } else {
                if (this.S[d].D.hasChildNodes()) {
                    this.S[d].D.insertBefore(this.S[d].BS, this.S[d].D.firstChild);
                }
            }
            if (!this.VIEW_BUTTONS) {
                OrgNode.hE(this.S[d].BS);
            }
            this.S[d].NAV = c;
            if (0 < this.S[d].CH.length && this.LOCAL_TOC) {
                var a = document.createElement("div");
                a.className = "org-info-js_local-toc";
                c = "Contents:<br /><ul>";
                for (var b = 0; b < this.S[d].CH.length;
                    ++b) {
                    c += '<li><a href="' + this.S[d].CH[b].L + '">' + this.rT(this.rOT(this.S[d].CH[b].H.innerHTML)) + "</a></li>";
                }
                c += "</ul>";
                a.innerHTML = c;
                if ("above" == this.LOCAL_TOC) {
                    if (this.S[d].F) {
                        this.S[d].F.insertBefore(a, this.S[d].F.firstChild);
                    } else {
                        this.S[d].D.insertBefore(a, this.S[d].D.getElementsByTagName("h" + this.S[d].DEPTH)[0].nextSibling);
                    }
                } else {
                    if (this.S[d].F) {
                        this.S[d].F.appendChild(a);
                    } else {
                        this.S[d].D.appendChild(a);
                    }
                }
            }
        }
        this.ST.sort();
    },
    set: function(eval_key, eval_val) {
        if ("VIEW" == eval_key) {
            var pos = eval_val.indexOf("_");
            if (-1 != pos) {
                this.IT = eval_val.substr(pos + 1);
                eval_val = eval_val.substr(0, pos);
            }
            var overview = this.PLAIN_VIEW;
            var content = this.CONTENT_VIEW;
            var showall = this.ALL_VIEW;
            var info = this.INFO_VIEW;
            var info_title_above = this.INFO_VIEW;
            var slide = this.SLIDE_VIEW;
            eval("this." + eval_key + "=" + eval_val + ";");
        } else {
            if ("HELP" == eval_key) {
                eval("this.STARTUP_MESSAGE=" + eval_val + ";");
            } else {
                if (eval_val) {
                    eval("this." + eval_key + "='" + eval_val + "';");
                } else {
                    eval("this." + eval_key + "=0;");
                }
            }
        }
    },
    convertLinks: function() {
        var f = (this.HIDE_TOC ? 0 : 1);
        var e;
        var a = this.S.length - 1;
        var d = document.getElementsByTagName("a");
        for (e = 0; e < d.length; ++e) {
            var c = d[e].href.replace(this.BU, "");
            for (var b = 0; b < this.S.length; ++b) {
                if (this.S[b].iTF[c]) {
                    d[e].href = "javascript:org_html_manager.go(" + b + ")";
                    break;
                }
            }
        }
    },
    ss: function(d) {
       var b = this;
        var f = parseInt(d);
        var c = b.N;
        var e = "onShowSection";
        if (b.HIDE_TOC && b.N == b.TOC && !b.FIXED_TOC) {
            OrgNode.hE(b.TOC.D);
            if (b.PLAIN_VIEW == b.VIEW) {
                b.R.sAC();
                for (var a = 0; a < b.R.CH.length; ++a) {
                    b.R.CH[a].ST = OrgNode.SU;
                    b.R.CH[a].fold();
                }
            }
        }
        if ("?/toc/?" != d && null != b.TL) {
            b.TL.blur();
        }
        if ("?/toc/?" == d || (!isNaN(f) && b.S[f])) {
            if ("?/toc/?" == d && b.HIDE_TOC) {
                e = "onShowToc";
                b.N = b.TOC;
                b.R.hAC();
                if (b.INFO_VIEW == b.VIEW) {
                    b.W.innerHTML = b.N.D.innerHTML;
                } else {
                    b.N.sSt(OrgNode.SU);
                }
                window.scrollTo(0, 0);
            } else {
                b.N = b.S[f];
                if (b.SLIDE_VIEW == b.VIEW || b.INFO_VIEW == b.VIEW) {
                    OrgNode.hE(b.N.BS);
                    b.N.sSt(OrgNode.SU);
                    for (var a = 0; a < b.N.CH.length; ++a) {
                        b.N.CH[a].hide();
                    }
                    if (b.SLIDE_VIEW == b.VIEW) {
                        b.W.innerHTML = b.N.D.innerHTML;
                    } else {
                        b.W.innerHTML = b.N.NAV + b.N.D.innerHTML;
                    }
                    b.N.hide();
                    if (!b.FIXED_TOC) {
                        OrgNode.hE(document.body);
                    }
                    if (c.J != b.N.J) {
                        if ("?/toc/?" != d) {
                            window.location.replace(b.BU + b.Q + b.dT());
                        }
                    }
                    if (!b.FIXED_TOC) {
                        OrgNode.sE(document.body);
                    }
                } else {
                    if (!b.VIEW_BUTTONS) {
                        OrgNode.hE(c.BS);
                    }
                    OrgNode.sE(b.N.BS);
                    b.N.sSt(OrgNode.UNFOLDED);
                    b.N.show();
                    if (c.J != b.N.J) {
                        window.location.replace(b.BU + b.Q + b.dT());
                    }
                    if (b.N.J == 0) {
                        window.scrollTo(0, 0);
                    } else {
                        b.N.D.scrollIntoView(true);
                    }
                }
            }
        }
        c.setLinkClass();
        b.N.setLinkClass(true);
        b.runHooks(e, {
            last: c,
            current: b.N
        });
    },
    pV: function(d, a) {
        var c = this;
        document.onclick = null;
        document.ondblclick = null;
        c.VIEW = c.PLAIN_VIEW;
        OrgNode.hE(c.W);
        if (c.IT) {
            OrgNode.hE(c.IT);
        }
        OrgNode.sE(c.T);
        if (c.W.firstChild) {
            c.W.removeChild(c.W.firstChild);
        }
        c.R.sAC();
        for (var b = 0; b < c.R.CH.length; ++b) {
            c.R.CH[b].ST = OrgNode.SU;
            c.R.CH[b].fold();
        }
        if (!a) {
            c.ss(d);
        }
        if (c.P) {
            OrgNode.sE(c.P);
        }
        if (c.N.J == 0) {
            window.scrollTo(0, 0);
        } else {
            c.N.D.scrollIntoView(true);
        }
    },
    iV: function(c, a) {
        var b = this;
        document.onclick = null;
        document.ondblclick = null;
        b.VIEW = b.INFO_VIEW;
        b.unhH(b.N.J);
        if (b.IT && !b.FIXED_TOC) {
            OrgNode.sE(b.IT);
            OrgNode.hE(b.T);
        }
        OrgNode.sE(b.W);
        b.R.hAC();
        if (b.TOC && !b.FIXED_TOC) {
            OrgNode.hE(b.TOC.D);
        }
        if (b.P) {
            OrgNode.sE(b.P);
        }
        if (!a) {
            b.ss(c);
        }
        window.scrollTo(0, 0);
    },
    sV: function(c, a) {
        var b = this;
        b.VIEW = b.SLIDE_VIEW;
        b.unhH(b.N.J);
        OrgNode.hE(b.T);
        if (b.IT) {
            OrgNode.hE(b.IT);
        }
        if (b.TOC) {
            OrgNode.hE(b.TOC.D);
        }
        OrgNode.sE(b.T);
        OrgNode.sE(b.W);
        b.R.hAC();
        OrgNode.hE(b.TOC.D);
        if (b.P) {
            OrgNode.hE(b.P);
        }
        b.adjustSlide(c);
        if (!a) {
            b.ss(c);
        }
    },
    adjustSlide: function(f, g) {
        var k = true;
        var e = true;
        var d = false;
        if (f > this.N.J) {
            d = true;
        }
        if (null == g) {
            d = true;
        }
        if (d) {
            for (var a = this.S[f].F.firstChild; null != a; a = a.nextSibling) {
                if ("UL" == a.nodeName) {
                    var j = a.getElementsByTagName("li");
                    for (var c = 1; c < j.length; ++c) {
                        var b = j[c];
                        OrgNode.hE(b);
                        k = false;
                    }
                }
            }
        } else {
            var h = this.W.getElementsByTagName("ul");
            for (var a = 0; a < h.length; ++a) {
                var j = h[a].getElementsByTagName("li");
                for (var c = 1; c < j.length;
                    ++c) {
                    var b = j[c];
                    if (g > 0) {
                        if (OrgNode.isHidden(b)) {
                            OrgNode.uhE(b);
                            if (c < (j.length - 1)) {
                                k = false;
                            }
                            if (0 < c) {
                                e = false;
                            }
                            break;
                        }
                    } else {
                        if (!OrgNode.isHidden(b)) {
                            if (1 < c) {
                                e = false;
                                OrgNode.hE(j[c - 1]);
                                break;
                            }
                        }
                    }
                }
            }
        }
        if (k) {
            document.onclick = function() {
                org_html_manager.sCk("org_html_manager.nextSection(org_html_manager.N.J + 1)");
            };
        } else {
            document.onclick = function() {
                org_html_manager.sCk("org_html_manager.adjustSlide(org_html_manager.N.J, +1)");
            };
        }
        if (e) {
            document.ondblclick = function() {
                org_html_manager.sCk("org_html_manager.previousSection()");
            };
        } else {
            document.ondblclick = function() {
                org_html_manager.sCk("org_html_manager.adjustSlide(" + this.N.J + ", -1)");
            };
        }
    },
    toggleView: function(b) {
        var a = this;
        a.Q = "";
        a.rW();
        if (a.VIEW == a.INFO_VIEW) {
            a.pV(b);
        } else {
            a.iV(b);
        }
    },
    fold: function(b) {
        var a = this;
        a.rW();
        var c = parseInt(b);
        a.S[c].fold();
        if (!a.VIEW_BUTTONS) {
            OrgNode.hE(a.N.BS);
        }
        a.N = a.S[c];
        OrgNode.sE(a.N.BS);
    },
    tG: function() {
        var b = this;
        if (b.R.DRT) {
            b.R.ST = OrgNode.SU;
        }
        if (OrgNode.SU == b.R.ST) {
            for (var a = 0; a < b.R.CH.length;
                ++a) {
                b.R.CH[a].ST = OrgNode.SU;
                b.R.CH[a].fold(true);
            }
            b.R.ST = OrgNode.SU;
            b.R.ST = OrgNode.SF;
        } else {
            if (OrgNode.SF == b.R.ST) {
                for (var a = 0; a < b.R.CH.length; ++a) {
                    b.R.CH[a].fold(true);
                }
                b.R.ST = OrgNode.SH;
            } else {
                for (var a = 0; a < b.R.CH.length; ++a) {
                    b.R.CH[a].fold();
                }
                b.R.ST = OrgNode.SU;
            }
        }
        b.R.DRT = false;
    },
    executeClick: function(func) {
        var t = this;
        if (t.Rg) {
            t.eR();
            t.hC();
        } else {
            if (t.Mg) {
                t.rW();
            }
        }
        eval(func);
        if (null != t.CTO) {
            t.CTO = null;
        }
    },
    sCk: function(b, a) {
        if (null == a) {
            a = 250;
        }
        if (null == this.CTO) {
            this.CTO = window.setTimeout("org_html_manager.executeClick(" + b + ")", a);
        } else {
            window.clearTimeout(this.CTO);
            this.CTO = null;
        }
    },
    nextSection: function() {
        var a = this;
        var b = a.N.J + 1;
        if (b < a.S.length) {
            a.go(b);
        } else {
            a.warn("Already last section.");
        }
    },
    previousSection: function() {
        var b = this;
        var a = b.N.J;
        if (a > 0) {
            b.go(a - 1);
        } else {
            b.warn("Already first section.");
        }
    },
    go: function(b) {
        var a = this;
        if (a.Rg) {
            a.eR();
            a.hC();
        } else {
            if (a.Mg) {
                a.rW();
            }
        }
        if (a.VIEW == a.SLIDE_VIEW) {
            a.adjustSlide(b);
        }
        a.puH(b, a.N.J);
        a.ss(b);
    },
    puH: function(c, a) {
        var b = this;
        if (!b.SKIP_H) {
            b.H[b.HI] = new Array(c, a);
            b.HI = (b.HI + 1) % 50;
        }
        b.SKIP_H = false;
        b.CI.value = "";
    },
    poH: function(c) {
        var a = this;
        if (c) {
            if (a.H[a.HI]) {
                var b = parseInt(a.H[a.HI][0]);
                if (!isNaN(b) || "?/toc/?" == a.H[a.HI][0]) {
                    a.ss(a.H[a.HI][0]);
                    a.CI.value = "";
                } else {
                    a.SKIP_H = true;
                    a.CI.value = a.H[a.HI][0];
                    a.getKey();
                }
                a.HI = (a.HI + 1) % 50;
                a.HBO = 0;
            } else {
                if (a.HFO && history.length) {
                    history.forward();
                } else {
                    a.HFO = 1;
                    a.warn("History: No where to foreward go from here. Any key and `B' to move to next file in history.");
                }
            }
        } else {
            if (a.H[a.HI - 1]) {
                a.HI = a.HI == 0 ? 49 : a.HI - 1;
                var b = parseInt(a.H[a.HI][1]);
                if (!isNaN(b) || "?/toc/?" == a.H[a.HI][1]) {
                    a.ss(a.H[a.HI][1]);
                    a.CI.value = "";
                } else {
                    a.SKIP_H = true;
                    a.CI.value = a.H[a.HI][1];
                    a.getKey();
                }
                a.HFO = 0;
            } else {
                if (a.HBO && history.length) {
                    history.back();
                } else {
                    a.HBO = 1;
                    a.warn("History: No where to back go from here. Any key and `b' to move to previous file in history.");
                }
            }
        }
    },
    warn: function(c, d, b) {
        var a = this;
        if (null == b) {
            b = "";
        }
        a.CI.value = b;
        if (!d) {
            a.CL.style.color = "red";
        }
        a.CL.innerHTML = "<span style='float:left;'>" + c + "</span><span style='float:right;color:#aaaaaa;font-weight:normal;'>(press any key to proceed)</span>";
        a.sC();
        window.setTimeout(function() {
            org_html_manager.CI.value = b;
        }, 50);
    },
    sR: function(e, b, d, a) {
        var c = this;
        if (null == d) {
            d = "";
        }
        if (null == a) {
            a = "";
        }
        c.RC = e;
        c.Rg = true;
        c.CL.innerHTML = "<span style='float:left;'>" + b + "</span><span style='float:right;color:#aaaaaa;font-weight:normal;'>(" + a + "RET to close)</span>";
        c.sC();
        document.onkeypress = null;
        c.CI.focus();
        c.CI.onblur = function() {
            org_html_manager.CI.focus();
        };
        window.setTimeout(function() {
            org_html_manager.CI.value = d;
        }, 50);
    },
    eR: function(c, a) {
        var b = this;
        b.Rg = false;
        b.RC = "";
        b.CI.onblur = null;
        b.CI.blur();
        document.onkeypress = OrgHtmlManagerKeyEvent;
    },
    rW: function() {
        var a = this;
        a.CL.style.color = "#333333";
        a.hC();
    },
    sC: function() {
        var a = this;
        if (!a.Mg) {
            if (a.VIEW == a.PLAIN_VIEW) {
                a.B.removeChild(a.B.firstChild);
                a.N.D.insertBefore(a.C, a.N.D.firstChild);
                a.N.D.scrollIntoView(true);
                a.Mg = a.MgI;
            } else {
                a.Mg = a.MgT;
                window.scrollTo(0, 0);
            }
            a.C.style.marginTop = "0px";
            a.C.style.top = "0px";
        }
    },
    hC: function() {
        var a = this;
        if (a.Mg) {
            a.C.style.marginTop = "-" + a.CO;
            a.C.style.top = "-" + a.CO;
            a.CL.innerHTML = "";
            a.CI.value = "";
            if (a.MgI == a.Mg) {
                a.N.D.removeChild(a.N.D.firstChild);
                a.B.insertBefore(a.C, a.B.firstChild);
                if (a.N.J != 0) {
                    a.N.D.scrollIntoView();
                }
            }
            a.Mg = false;
        }
    },
    getKey: function() {
        var b = this;
        var c = b.CI.value;
        if (0 == c.length) {
            if (b.Hg) {
                b.showHelp();
                return;
            }
            if (b.Mg && !b.Rg) {
                b.rW();
            }
            return;
        }
        if (b.Mg && !b.Rg) {
            b.rW();
            return;
        } else {
            if (b.Hg) {
                b.showHelp();
                b.CI.value = "";
                return;
            } else {
                if (b.Rg) {
                    return;
                }
            }
        }
        b.CI.value = "";
        b.CI.blur();
        if (b.HIDE_TOC && b.TOC == b.N && "v" != c && "V" != c && "\t" != c) {
            c = "b";
        } else {
            if ("\t" == c) {
                return true;
            } else {
                c = b.trim(c);
            }
        }
        if (1 == c.length) {
            switch (c) {
                                //go back to last visited section
                case "b":
                    b.poH();
                    break;
                case "B": // forward to next visited section
                    b.poH(true);
                    break;
                                // show table of contents
                case "i":
                    if (!b.FIXED_TOC) {
                        if (b.HIDE_TOC) {
                            b.go("?/toc/?");
                        } else {
                            if (0 != b.N.J) {
                                b.go(0);
                            }
                        }
                    }
                    if (null != b.TL) {
                        b.TL.focus();
                    }
                    break;
                                // toggle the view mode between info and plain
                case "m":
                    b.toggleView(b.N.J);
                    return;
                    break;
                                // go to slide view (how do you get out of this view?)
                case "x":
                    b.sV(b.N.J);
                    break;
                                // go to next section
                case "n":
                    if (b.N.ST == OrgNode.SF && b.VIEW == b.PLAIN_VIEW) {
                        b.ss(b.N.J);
                    } else {
                        if (b.N.J < b.S.length - 1) {
                            b.go(b.N.J + 1);
                        } else {
                            b.warn("Already last section.");
                            return;
                        }
                    }
                    break;
                                // go to next sibling                       
                case "N":
                    if (b.N.J < b.S.length - 1) {
                        var e = b.N.DEPTH;
                        var a = b.N.J + 1;
                        while (a < b.S.length - 1 && b.S[a].DEPTH >= e) {
                            if (b.S[a].DEPTH == e) {
                                b.go(a);
                                return;
                            }++a;
                        }
                    }
                    b.warn("No next sibling.");
                    return;
                    break;
                                // go to previous section
                case "p":
                    if (b.N.J > 0) {
                        b.go(b.N.J - 1);
                    } else {
                        b.warn("Already first section.");
                        return;
                    }
                    break;
                                // go to previous sibling
                case "P":
                    if (b.N.J > 0) {
                        var e = b.N.DEPTH;
                        var a = b.N.J - 1;
                        while (a >= 0 && b.S[a].DEPTH >= e) {
                            if (b.S[a].DEPTH == e) {
                                b.go(a);
                                return;
                            }--a;
                        }
                    }
                    b.warn("No previous sibling.");
                    break;
                                // close the window (not listed in help section!)
                case "q":
                    if (window.confirm("Really close this file?")) {
                        window.close();
                    }
                    break;
                                // go to first section
                case "t":
                                // (not listed in help section!)
                case "<":
                    if (0 != b.N.J) {
                        b.go(0);
                    } else {
                        window.scrollTo(0, 0);
                    }
                    break;
                                // go to last section
                case "E":
                                // (not listed in help section!)
                case "e":
                                // (not listed in help section!)
                case ">":
                    if ((b.S.length - 1) != b.N.J) {
                        b.go(b.S.length - 1);
                    } else {
                        b.S[b.S.length - 1].D.scrollIntoView(true);
                    }
                    break;
                                // scroll down
                case "v":
                    if (window.innerHeight) {
                        window.scrollBy(0, window.innerHeight - 30);
                    } else {
                        if (document.documentElement.clientHeight) {
                            window.scrollBy(0, document.documentElement.clientHeight - 30);
                        } else {
                            window.scrollBy(0, document.body.clientHeight - 30);
                        }
                    }
                    break;
                                // scroll up
                case "V":
                    if (window.innerHeight) {
                        window.scrollBy(0, -(window.innerHeight - 30));
                    } else {
                        if (document.documentElement.clientHeight) {
                            window.scrollBy(0, -(document.documentElement.clientHeight - 30));
                        } else {
                            window.scrollBy(0, -(document.body.clientHeight - 30));
                        }
                    }
                    break;
                                // go one level up (parent section) (obsolete?)
                case "u":
                    if (b.N.P != b.R) {
                        b.N = b.N.P;
                        b.ss(b.N.J);
                    }
                    break;
                                // print (un-necessary?)
                case "W":
                    b.pV(b.N.J);
                    b.R.DRT = true;
                    b.R_STATE = OrgNode.SU;
                    b.tG();
                    b.tG();
                    b.tG();
                    window.print();
                    break;
                                // fold current section
                case "f":
                    if (b.VIEW != b.INFO_VIEW) {
                        b.N.fold();
                        b.N.D.scrollIntoView(true);
                    }
                    break;
                                // fold whole document (plain view only)
                case "F":
                    if (b.VIEW != b.INFO_VIEW) {
                        b.tG();
                        b.N.D.scrollIntoView(true);
                    }
                    break;
                                // show the help screen
                case "?":
                case "Â¿":
                    b.showHelp();
                    break;
                                // show tags index
                case "C":
                    if (b.ST.length) {
                        b.showTagsIndex();
                    } else {
                        b.warn("No Tags found.");
                    }
                    break;
                                // go to link HOME page
                case "H":
                    if (b.LINK_HOME) {
                        window.document.location.href = b.LINK_HOME;
                    }
                    break;
                                // go to main index in this directory
                case "h":
                    if (b.LINK_UP) {
                        window.document.location.href = b.LINK_UP;
                    }
                    break;
                                // display HTML link
                case "l":
                    if ("" != b.OCCUR) {
                        b.sR(b.RC_H, "Choose HTML-link type: 's' = section, 'o' = occur");
                    } else {
                        b.sR(c, "HTML-link:", '<a href="' + b.BU + b.dT() + '">' + document.title + ", Sec. '" + b.rT(b.N.H.innerHTML) + "'</a>", "C-c to copy, ");
                        window.setTimeout(function() {
                            org_html_manager.CI.select();
                        }, 100);
                    }
                    return;
                    break;
                                // display Org link
                case "L":
                    if ("" != b.OCCUR) {
                        b.sR(b.RC_O, "Choose Org-link type: 's' = section, 'o' = occur");
                    } else {
                        b.sR(c, "Org-link:", "[[" + b.BU + b.dT() + "][" + document.title + ", Sec. '" + b.rT(b.N.H.innerHTML) + "']]", "C-c to copy, ");
                        window.setTimeout(function() {
                            org_html_manager.CI.select();
                        }, 100);
                    }
                    return;
                    break;
                                // display Plain-URL
                case "U":
                    if ("" != b.OCCUR) {
                        b.sR(b.RC_P, "Choose Org-link type: 's' = section, 'o' = occur");
                    } else {
                        b.sR(c, "Plain URL Link:", b.BU + b.dT(), "C-c to copy, ");
                        window.setTimeout(function() {
                            org_html_manager.CI.select();
                        }, 100);
                    }
                    return;
                    break;
                                // go to section...
                case "g":
                    b.sR(c, "Enter section number:");
                    return;
                    break;
                                // occur mode
                case "o":
                    if ("" != b.OCCUR) {
                        b.sR(c, "Occur:", b.OCCUR, "RET to use previous, DEL ");
                    } else {
                        b.sR(c, "Occur:", b.OCCUR);
                    }
                    window.setTimeout(function() {
                        org_html_manager.CI.value = org_html_manager.OCCUR;
                        org_html_manager.CI.select();
                    }, 100);
                    return;
                    break;
                                // search forward
                case "s":
                    if ("" != b.OCCUR) {
                        b.sR(c, "Search forward:", b.OCCUR, "RET to use previous, DEL ");
                    } else {
                        b.sR(c, "Search forward:", b.OCCUR);
                    }
                    window.setTimeout(function() {
                        org_html_manager.CI.value = org_html_manager.OCCUR;
                        org_html_manager.CI.select();
                    }, 100);
                    return;
                    break;
                                // search again forward
                case "S":
                    if ("" == b.OCCUR) {
                        c = "s";
                        b.sR(c, "Search forward:");
                    } else {
                        b.RC = c;
                        b.eRC();
                    }
                    return;
                    break;
                                // search backward
                case "r":
                    if ("" != b.OCCUR) {
                        b.sR(c, "Search backwards:", b.OCCUR, "RET to use previous, DEL ");
                    } else {
                        b.sR(c, "Search backwards:", b.OCCUR);
                    }
                    window.setTimeout(function() {
                        org_html_manager.CI.value = org_html_manager.OCCUR;
                        org_html_manager.CI.select();
                    }, 100);
                    return;
                    break;
                                // search again backward
                case "R":
                    if ("" == b.OCCUR) {
                        c = "r";
                        b.sR(c, "Search backwards:");
                    } else {
                        b.RC = c;
                        b.eRC();
                    }
                    return;
                    break;
                                // clear search-highlight                
                case "c":
                    b.rSH();
                    if (b.VIEW == b.INFO_VIEW || b.VIEW == b.SLIDE_VIEW) {
                        b.ss(b.N.J);
                    }
                    break;
            }
        }
        return;
    },
    eRC: function() {
        var j = this;
        var a = j.RC;
        var k = j.trim(j.CI.value);
        j.eR();
        if ("" == a || "" == k) {
            j.hC();
            return;
        }
        if (a == "g") {
            var f = j.SN_MAP[k];
            if (null != f) {
                j.hC();
                j.go(f.J);
                return;
            }
            j.warn("Goto section: no such section.", false, k);
            return;
        } else {
            if (a == "s") {
                if ("" == k) {
                    return false;
                }
                if (j.SHO) {
                    j.rSH();
                }
                var g = j.OCCUR;
                var e = 0;
                if (k == j.OCCUR) {
                    e++;
                }
                j.OCCUR = k;
                j.mSR();
                for (var d = j.N.J + e; d < j.S.length; ++d) {
                    if (j.sIO(d)) {
                        j.OCCUR = k;
                        j.hC();
                        j.go(j.S[d].J);
                        return;
                    }
                }
                j.warn("Search forwards: text not found.", false, j.OCCUR);
                j.OCCUR = g;
                return;
            } else {
                if (a == "S") {
                    for (var d = j.N.J + 1; d < j.S.length; ++d) {
                        if (j.sIO(d)) {
                            j.hC();
                            j.go(j.S[d].J);
                            return;
                        }
                    }
                    j.warn("Search forwards: text not found.", false, j.OCCUR);
                    return;
                } else {
                    if (a == "r") {
                        if ("" == k) {
                            return false;
                        }
                        if (j.SHO) {
                            j.rSH();
                        }
                        var g = j.OCCUR;
                        j.OCCUR = k;
                        var e = 0;
                        if (k == j.OCCUR) {
                            e++;
                        }
                        j.mSR();
                        for (var d = j.N.J - e; d > -1; --d) {
                            if (j.sIO(d)) {
                                j.hC();
                                j.go(j.S[d].J);
                                return;
                            }
                        }
                        j.warn("Search backwards: text not found.", false, j.OCCUR);
                        j.OCCUR = g;
                        return;
                    } else {
                        if (a == "R") {
                            for (var d = j.N.J - 1; d > -1; --d) {
                                k = j.rT(j.S[d].H.innerHTML);
                                if (j.sIO(d)) {
                                    j.hC();
                                    j.go(j.S[d].J);
                                    return;
                                }
                            }
                            j.warn("Search backwards: text not found.", false, j.OCCUR);
                            return;
                        } else {
                            if (a == "o") {
                                if ("" == k) {
                                    return false;
                                }
                                if (j.SHO) {
                                    j.rSH();
                                }
                                var g = j.OCCUR;
                                j.OCCUR = k;
                                j.mSR();
                                var b = new Array();
                                for (var d = 0; d < j.S.length; ++d) {
                                    if (j.sIO(d)) {
                                        b.push(d);
                                    }
                                }
                                if (0 == b.length) {
                                    j.warn("Occur: text not found.", false, j.OCCUR);
                                    j.OCCUR = g;
                                    return;
                                }
                                j.hC();
                                if (j.PLAIN_VIEW != j.VIEW) {
                                    j.pV();
                                }
                                j.R.DRT = true;
                                j.tG();
                                for (var d = 0; d < j.S.length;
                                    ++d) {
                                    OrgNode.sE(j.S[d].D);
                                    OrgNode.hE(j.S[d].F);
                                }
                                for (var d = (b.length - 1); d >= 1; --d) {
                                    OrgNode.sE(j.S[b[d]].F);
                                }
                                j.ss(b[0]);
                            } else {
                                if (a == j.RC_O) {
                                    var h = k.charAt(0);
                                    if ("s" == h) {
                                        j.sR(j.RC_NULL, "Org-link to this section:", "[[" + j.BU + j.dT() + "][" + document.title + ", Sec. '" + j.rT(j.N.H.innerHTML) + "']]", "C-c to copy, ");
                                        window.setTimeout(function() {
                                            org_html_manager.CI.select();
                                        }, 100);
                                    } else {
                                        if ("o" == h) {
                                            j.sR(j.RC_NULL, "Org-link, occurences of <i>&quot;" + j.OCCUR + "&quot;</i>:", "[[" + j.BU + "?OCCUR=" + j.OCCUR + "][" + document.title + ", occurences of '" + j.OCCUR + "']]", "C-c to copy, ");
                                            window.setTimeout(function() {
                                                org_html_manager.CI.select();
                                            }, 100);
                                        } else {
                                            j.warn(h + ": No such link type!");
                                        }
                                    }
                                } else {
                                    if (a == j.RC_H) {
                                        var h = k.charAt(0);
                                        if ("s" == h) {
                                            j.sR(j.RC_NULL, "HTML-link to this section:", '<a href="' + j.BU + j.dT() + '">' + document.title + ", Sec. '" + j.rT(j.N.H.innerHTML) + "'</a>", "C-c to copy, ");
                                            window.setTimeout(function() {
                                                org_html_manager.CI.select();
                                            }, 100);
                                        } else {
                                            if ("o" == h) {
                                                j.sR(j.RC_NULL, "HTML-link, occurences of <i>&quot;" + j.OCCUR + "&quot;</i>:", '<a href="' + j.BU + "?OCCUR=" + j.OCCUR + '">' + document.title + ", occurences of '" + j.OCCUR + "'</a>", "C-c to copy, ");
                                                window.setTimeout(function() {
                                                    org_html_manager.CI.select();
                                                }, 100);
                                            } else {
                                                j.warn(h + ": No such link type!");
                                            }
                                        }
                                    } else {
                                        if (a == j.RC_P) {
                                            var h = k.charAt(0);
                                            if ("s" == h) {
                                                j.sR(j.RC_NULL, "Plain-link to this section:", j.BU + j.dT(), "C-c to copy, ");
                                                window.setTimeout(function() {
                                                    org_html_manager.CI.select();
                                                }, 100);
                                            } else {
                                                if ("o" == h) {
                                                    j.sR(j.RC_NULL, "Plain-link, occurences of <i>&quot;" + j.OCCUR + "&quot;</i>:", j.BU + "?OCCUR=" + j.OCCUR, "C-c to copy, ");
                                                    window.setTimeout(function() {
                                                        org_html_manager.CI.select();
                                                    }, 100);
                                                } else {
                                                    j.warn(h + ": No such link type!");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    dT: function(b) {
        if (null == b) {
            b = this.N;
        }
        var c = "#" + this.N.I;
        for (var a in b.iTF) {
            if (!a.match(this.SIDX)) {
                c = a;
                break;
            }
        }
        return c;
    },
    mSR: function() {
        var a = this.OCCUR.replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/=/g, "\\=").replace(/\\/g, "\\\\").replace(/\?/g, "\\?").replace(/\)/g, "\\)").replace(/\(/g, "\\(").replace(/\./g, "[^<>]").replace(/\"/g, "&quot;");
        this.SCX = new RegExp(">([^<]*)?(" + a + ")([^>]*)?<", "ig");
    },
    sIO: function(c) {
        var b = this;
        var a = false;
        if (null != b.S[c]) {
            if (b.SCX.test(b.S[c].H.innerHTML)) {
                a = true;
                b.sSH(b.S[c].H);
                b.S[c].HH = true;
                b.SHO = true;
            }
            if (b.SCX.test(b.S[c].F.innerHTML)) {
                a = true;
                b.sSH(b.S[c].F);
                b.S[c].HH = true;
                b.SHO = true;
            }
            return a;
        }
        return false;
    },
    sSH: function(b) {
        var a = b.innerHTML;
        b.innerHTML = a.replace(this.SCX, '>$1<span class="org-info-js_search-highlight">$2</span>$3<');
    },
    rSH: function() {
        var c = this;
        for (var b = 0; b < c.S.length; ++b) {
            if (c.S[b].HH) {
                while (c.SC_HLX.test(c.S[b].H.innerHTML)) {
                    var a = c.S[b].H.innerHTML;
                    c.S[b].H.innerHTML = a.replace(c.SC_HLX, "$2");
                }
                while (c.SC_HLX.test(c.S[b].F.innerHTML)) {
                    var a = c.S[b].F.innerHTML;
                    c.S[b].F.innerHTML = a.replace(c.SC_HLX, "$2");
                }
                c.S[b].HH = false;
            }
        }
        c.SHO = false;
    },
    hH: function(b) {
        var a = parseInt(b);
        if (this.PLAIN_VIEW == this.VIEW && this.MOUSE_HINT) {
            if ("underline" == this.MOUSE_HINT) {
                this.S[a].H.style.borderBottom = "1px dashed #666666";
            } else {
                this.S[a].H.style.backgroundColor = this.MOUSE_HINT;
            }
        }
    },
    unhH: function(b) {
        var a = parseInt(b);
        if ("underline" == this.MOUSE_HINT) {
            this.S[a].H.style.borderBottom = "";
        } else {
            this.S[a].H.style.backgroundColor = "";
        }
    },
    showHelp: function() {
        var a = this;
        if (a.Rg) {
            a.eR();
        } else {
            if (a.Mg) {
                a.rW();
            }
        }
        a.Hg = a.Hg ? 0 : 1;
        if (a.Hg) {
            a.LVM = a.VIEW;
            if (a.PLAIN_VIEW == a.VIEW) {
                a.iV(true);
            }
            a.W.innerHTML = 'Press any key or <a href="javascript:org_html_manager.showHelp();">click here</a> to proceed.<h2>Keyboard Shortcuts</h2><table cellpadding="3" rules="groups" frame="hsides" style="caption-side:bottom;margin:20px;border-style:none;" border="0";><caption><small>org-info.js, v. 0.1.7.1</small></caption><tbody><tr><td><code><b>? / &iquest;</b></code></td><td>show this help screen</td></tr></tbody><tbody><tr><td><code><b></b></code></td><td><b>Moving around</b></td></tr><tr><td><code><b>n / p</b></code></td><td>goto the next / previous section</td></tr><tr><td><code><b>N / P</b></code></td><td>goto the next / previous sibling</td></tr><tr><td><code><b>t / E</b></code></td><td>goto the first / last section</td></tr><tr><td><code><b>g</b></code></td><td>goto section...</td></tr><tr><td><code><b>u</b></code></td><td>go one level up (parent section)</td></tr><tr><td><code><b>i / C</b></code></td><td>show table of contents / tags index</td></tr><tr><td><code><b>b / B</b></code></td><td>go back to last / forward to next visited section.</td></tr><tr><td><code><b>h / H</b></code></td><td>go to main index in this directory / link HOME page</td></tr></tbody><tbody><tr><td><code><b></b></code></td><td><b>View</b></td></tr><tr><td><code><b>m / x</b></code></td><td>toggle the view mode between info and plain / slides</td></tr><tr><td><code><b>f / F</b></code></td><td>fold current section / whole document (plain view only)</td></tr></tbody><tbody><tr><td><code><b></b></code></td><td><b>Searching</b></td></tr><tr><td><code><b>s / r</b></code></td><td>search forward / backward....</td></tr><tr><td><code><b>S / R</b></code></td><td>search again forward / backward</td></tr><tr><td><code><b>o</b></code></td><td>occur-mode</td></tr><tr><td><code><b>c</b></code></td><td>clear search-highlight</td></tr></tbody><tbody><tr><td><code><b></b></code></td><td><b>Misc</b></td></tr><tr><td><code><b>l / L / U</b></code></td><td>display HTML link / Org link / Plain-URL</td></tr><tr><td><code><b>v / V</b></code></td><td>scroll down / up</td></tr><tr><td><code><b>W</b></code></td><td>Print</td></tr></tbody></table><br />Press any key or <a href="javascript:org_html_manager.showHelp();">click here</a> to proceed.';
            window.scrollTo(0, 0);
        } else {
            if (a.PLAIN_VIEW == a.LVM) {
                a.pV();
            } else {
                if (a.SLIDE_VIEW == a.LVM) {
                    a.sV();
                }
            }
            a.ss(a.N.J);
        }
    },
    showTagsIndex: function() {
        var e = this;
        if (e.Rg) {
            e.eR();
        } else {
            if (e.Mg) {
                e.rW();
            }
        }
        e.Hg = e.Hg ? 0 : 1;
        if (e.Hg) {
            e.LVM = e.VIEW;
            if (e.PLAIN_VIEW == e.VIEW) {
                e.iV(true);
            }
            if (null == e.TAGS_INDEX) {
                e.TAGS_INDEX = 'Press any key or <a href="javascript:org_html_manager.showTagsIndex();">click here</a> to proceed.<br /><br />Click the headlines to expand the contents.<h2>Index of Tags</h2>';
                for (var d = 0; d < e.ST.length; ++d) {
                    var b = e.ST[d];
                    var f = "org-html-manager-sorted-tags-" + b;
                    e.TAGS_INDEX += "<a href=\"javascript:OrgNode.toggleElement(document.getElementById('" + f + "'));\"><h3>" + b + '</h3></a><div id="' + f + '" style="visibility:hidden;display:none;"><ul>';
                    for (var c = 0; c < e.TAGS[b].length; ++c) {
                        var a = e.TAGS[b][c];
                        e.TAGS_INDEX += '<li><a href="javascript:org_html_manager.ss(' + a + ');">' + e.S[a].H.innerHTML + "</a></li>";
                    }
                    e.TAGS_INDEX += "</ul></div>";
                }
                e.TAGS_INDEX += '<br />Press any key or <a href="javascript:org_html_manager.showTagsIndex();">click here</a> to proceed.';
            }
            e.W.innerHTML = e.TAGS_INDEX;
            window.scrollTo(0, 0);
        } else {
            if (e.PLAIN_VIEW == e.LVM) {
                e.pV();
            } else {
                if (e.SLIDE_VIEW == e.LVM) {
                    e.sV();
                }
            }
            e.ss(e.N.J);
        }
    },
    runHooks: function(b, a) {
        if (this.HOOKS.run_hooks && this.HOOKS[b]) {
            for (var c = 0; c < this.HOOKS[b].length; ++c) {
                this.HOOKS[b][c](this, a);
            }
        }
    },
    addHook: function(a, b) {
        if ("run_hooks" != a) {
            this.HOOKS[a].push(b);
        }
    },
    removeHook: function(a, c) {
        if (this.HOOKS[a]) {
            for (var b = this.HOOKS[a].length - 1; b >= 0;
                --b) {
                if (this.HOOKS[a][b] == c) {
                    this.HOOKS[a].splice(b, 1);
                }
            }
        }
    }
};
function OrgHtmlManagerKeyEvent(b) {
    var d;
    if (!b) {
        b = window.event;
    }
    if (b.which) {
        d = b.which;
    } else {
        if (b.keyCode) {
            d = b.keyCode;
        }
    }
    if (b.ctrlKey) {
        return;
    }
    var a = String.fromCharCode(d);
    if (b.shiftKey) {
        org_html_manager.CI.value = org_html_manager.CI.value + a;
    } else {
        org_html_manager.CI.value = org_html_manager.CI.value + a.toLowerCase();
    }
    org_html_manager.getKey();
}
function OrgHtmlManagerLoadCheck() {
    org_html_manager.init();
}
