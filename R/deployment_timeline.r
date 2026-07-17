#' Create a Timeline Showing any Receiver Failures
#'
#' This function creates a timeline of GPS hits (read from raw data using the [read_sg_gps()] function) that can be used to determine any gaps in data collection resulting from power issues or other problems. Normally, GPS hits are collected by the Sensorgnome every minute, so significant gaps can indicate equipment issues. This function is designed to recreate part of the Deployment Timeline available for station managers on the Motus website. The timeline is exported as an image.
#' @param x a dataframe created by the [read_sg_gps()] function.
#' @param filename File name to create on disk.
#' @param path Path of the directory to save plot to: path and filename are combined to create the fully qualified file name. Defaults to the working directory.
#' @param create.dir Whether to create new directories if a non-existing directory is specified in the filename or path (TRUE) or return an error (FALSE, default). If FALSE and run in an interactive session, a prompt will appear asking to create a new directory when necessary.
#' @export

deployment_timeline <- function(x,
                                filename,
                                path = NULL,
                                create.dir = FALSE) {

  if (is.null(path)) {
    wd <- getwd()

    path = wd
  }

  gps <- x

  gps <- gps[, names(gps) != "" & !is.na(names(gps))]

  gps <- gps |>
    dplyr::distinct(time, .keep_all = TRUE)

  gps <- gps[order(gps$time), ]

  gps$diff <- difftime(gps$time, dplyr::lag(gps$time))

  width <- signif(dplyr::n_distinct(lubridate::date(gps$time))/3,digits = 2)

  plot <- ggplot2::ggplot()+
    ggplot2::geom_point(data = gps, ggplot2::aes(x = time, y = 0), color = "forestgreen", shape = 15)+
    ggplot2::scale_x_datetime(date_breaks = "1 day", date_labels = "%m-%d-%y", expand = ggplot2::expansion(c(0.005, 0.005)))+
    ggplot2::theme_minimal()+
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1),
                 axis.text.y = ggplot2::element_blank())+
    ggplot2::labs(y= "")

  ggplot2::ggsave(filename = filename,plot = plot,width = width, height = 2, limitsize = F, path = path, create.dir = create.dir)

}
