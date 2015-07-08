package com.company;

import java.io.IOException;

public class Main {

    public static void main(String[] args) throws IOException, NoSuchMethodException, IllegalAccessException, InstantiationException, ClassNotFoundException {
        String link = "http://www.theatlantic.com/magazine/archive/1945/07/as-we-may-think/303881/?single_page=true";
//        String link = "http://www.newyorker.com/magazine/2012/08/06/marathon-man?currentPage=all";
//        String link = "http://www.nytimes.com/2012/02/19/magazine/shopping-habits.html?ref=general&src=me&pagewanted=all&_r=0";
        System.out.print(numberOfWordsFor(link));
    }

    public static int numberOfWordsFor(String link) throws ClassNotFoundException, IllegalAccessException, InstantiationException, IOException {
        NewsHandler obj = (NewsHandler) Class.forName("com.company." + className(link)).newInstance();
        return obj.receiveLink(link).result();
    }

    public static String className(String link){
        int index = link.indexOf("www.") + 4;
        String domain = link.substring(index, link.indexOf('/', index)-4);
        return domain.substring(0, 1).toUpperCase() + domain.substring(1);
    }
}
