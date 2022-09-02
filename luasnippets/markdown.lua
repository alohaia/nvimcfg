return {
    s("more", t{"<!--more-->", ""}),
    s("br", t"<br/>"),
    s("per", {
        i(1, "0"), t"%",
        c(3, {i(1,"～"), i(1,"~")}),
        i(2, "100"), t"%", i(0)
    }),
    s("to", {
        i(1, "0"),
        c(3, {i(1,"～"), i(1,"~")}),
        i(2, "100"), i(0)
    }),
    s({trig = "h([1-6])", regTrig = true},
        f(function(args, snip)
            return string.rep("#", tonumber(snip.captures[1])) .. " "
        end, {}),
        i(0)
    ),
    s("icd", { t"`", i(1), t"`" }),
    s("mcd", {
        t"```", i(1),
        sn(2, {t" { hl_lines=[", i(1), t"], linenostart=", i(2,"1"), t" }"}),
        t{"", ""}, i(3),
        t{"", "```"}
    }),
    s("mm", {t"$", i(1), t"$", i(0)}),
    s("MM", {t"$$", i(1), t{"", [[\\,.$$]]}}),
    s("bd", { t"**", i(1), t"**", i(0) }),
    s("it", { t"*", i(1), t"*", i(0) }),
    s("ins", { t"<ins>", i(1), t"</ins>", i(0) }),
    s("ib", { t"***", i(1), t"***", i(0) }),
    s("del", { t"~~", i(1), t"~~", i(0) }),
    s("sub", { t"<sub>", i(1), t"</sub>", i(0) }),
    s("sup", { t"<sup>", i(1), t"</sup>", i(0) }),
    s("hl", { t"<mark>", i(1), t"</mark>", i(0) }),
    s("anc", {
        t"[", i(1), t"](#",
        f(function (args, snip)
            return args[1][1]:gsub("%s+", "-"):lower()
        end, 1),
        t")", i(0)
    }),
    s("tag", { t"{{% ", i(1, "tag"), t" ", i(2), t" %}}", i(0) }),
    s("ref", {
        t"[", i(1), t']({{< ref "',
        f(function (args, snip)
            return args[1][1]
        end, 1),
        t{'" >}})'}, i(0)
    }),
    s("rrf", {
        t"[", i(1), t']({{< relref "',
        f(function (args, snip)
            return args[1][1]
        end, 1),
        t{'" >}})'}, i(0)
    }),
    s("fig", {
        t'{{< figure src="', i(1), t".", i(2, "png"),
        t('" title="'), i(3), t'"',
        d(4, function (args)
            if args[1][1] ~= "" then
                return sn(nil, {t' alt="', i(1, args[1][1]), t'"'})
            else
                return sn(nil, {})
            end
        end, 3),
        d(5, function (args)
            if args[1][1] ~= "" then
                return sn(nil, {t' id="', i(1, "fig_"..args[1][1]:gsub("%s+", "-"):lower()), t'"'})
            else
                return sn(nil, {})
            end
        end, 3),
        t" >}}"
    }),
    s("tbl", {
        t'{{% table title="', i(1),
        t'" caption="', i(2),
        t'" left_sticky=', c(3, {i(1,"true"), i(1,"false")}),
        d(4, function (args)
            if args[1][1] ~= "" then
                return sn(nil, {t' id="', i(1, "fig_"..args[1][1]:gsub("%s+", "-"):lower()), t'"'})
            else
                return sn(nil, {})
            end
        end, 1), t{" %}}", ""},
        i(0),
        t{"", "{{% /table %}}"}
    }),
    s("tab", {
        t'{{% tab type="', i(1,"default"),
        t('" summary="'), i(2),
        t'" details=', c(3, {i(1,"true"), i(1,"false")}),
        d(4, function(args)
            if args[1][1] == "true" then
                return sn(nil, {
                    t" open=", c(1, {i(1,"true"), i(1,"false")})
                })
            else
                return sn(nil, {})
            end
        end, 3),
        t{" %}}", ""},
        i(0),
        t{"", "{{% /tab %}}"},
    }),
    s("hzl", { t"{{% hzl %}}", i(1), t"{{% /hzl %}}", i(0) }),
    s("hdt", { t'{{% hdt "', i(1), t'" %}}', i(0) }),
    s("sa", { t"{{% sa %}}", i(1), t"{{% /sa %}}", i(0) }),
}
