package app.controller;

import app.service.CourseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/course")
@ComponentScan("app")
@Component
public class CourseController {

    @Autowired
    CourseServiceImpl courseService;
}
